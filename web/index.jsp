<%@ page import="java.util.*, java.sql.*, clases.ConnMysql" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registros en la base de datos</title>
</head>
<body>
    <h1>Registros en la base de datos</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Nota</th>
                <th>Fecha</th>
                <th colspan="2">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                ConnMysql conexion = new ConnMysql();
                Connection conn = conexion.getConnection();
                
                if (conn != null) {
                    try {
                        String query = "SELECT * FROM alumnos";
                        PreparedStatement ps = conn.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String nombre = rs.getString("nombre");
                            int nota = rs.getInt("nota");
                            java.sql.Date fecha = rs.getDate("fecha");
            %>
            <tr>
                <!-- Formulario para editar -->
                <form action="s2editar" method="post">
                    <td>
                        <!-- Campo Nombre, editable -->
                        <input type="text" name="nombre" value="<%= nombre %>" />
                    </td>
                    <td>
                        <!-- Campo Nota, editable -->
                        <input type="number" name="nota" value="<%= nota %>" />
                    </td>
                    <td>
                        <!-- Campo Fecha, editable -->
                        <input type="date" name="fecha" value="<%= fecha %>" />
                    </td>
                    <td>
                        <!-- Botón de editar, dentro del formulario -->
                        <button type="submit" name="action" value="edit">Editar</button>
                    </td>
                    <input type="hidden" name="id" value="<%= id %>">
                    <td>
                        <!-- Formulario para borrar -->
                <form action="s3borrar" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= id %>">
                    <button type="submit">Borrar</button>
                </form>
                    </td>
                </form>
                
                
            </tr>

            <%
                        }
                        rs.close();
                        ps.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        ConnMysql.cerrarConexion();
                    }
                } else {
                    out.println("<tr><td colspan='4'>No se pudo conectar a la base de datos.</td></tr>");
                }
            %>
        </tbody>
    </table>

    <h2>Insertar</h2>
    <form action="s1insertar" method="post">
        <label for="nombre">Nuevo nombre</label>
        <input type="text" name="nombre" required>
        <br>
        <label for="nota">Nota</label>
        <input type="number" name="nota" required>
        <br>
        <label for="fecha">Fecha</label>
        <input type="date" name="fecha" required>
        <br>
        <button type="submit">Insertar</button>
    </form>
</body>
</html>
