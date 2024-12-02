<%@ page import="java.util.*, java.sql.*" %>
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
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Conexión a la base de datos
                String url = "jdbc:mysql://localhost:3306/registros_db";
                String user = "root";
                String password = "root";
                
                try (Connection conn = DriverManager.getConnection(url, user, password)) {
                    String query = "SELECT * FROM registros";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String nombre = rs.getString("nombre");
                        int nota = rs.getInt("nota");
                        Date fecha = rs.getDate("fecha");
            %>
            <tr>
                <td><%= nombre %></td>
                <td><%= nota %></td>
                <td><%= fecha %></td>
                <td>
                    <form action="EditarServlet" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit">Editar</button>
                    </form>
                    <form action="BorrarServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit">Borrar</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <h2>Insertar</h2>
    <form action="InsertarServlet" method="post">
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
