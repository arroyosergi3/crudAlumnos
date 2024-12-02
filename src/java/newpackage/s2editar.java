import clases.ConnMysql;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "s2editar", urlPatterns = {"/s2editar"})
public class s2editar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener los parámetros del formulario
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String nota = request.getParameter("nota");
        String fecha = request.getParameter("fecha");

        if (id == null || id.isEmpty() || nombre == null || nombre.isEmpty() || 
            nota == null || nota.isEmpty() || fecha == null || fecha.isEmpty()) {
            response.getWriter().println("Todos los campos son obligatorios.");
            return;
        }

        // Establecer la conexión y ejecutar la actualización en la base de datos
        ConnMysql conexion = new ConnMysql();
        Connection conn = conexion.getConnection();
        if (conn != null) {
            try {
                String sql = "UPDATE alumnos SET nombre = ?, nota = ?, fecha = ? WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setInt(2, Integer.parseInt(nota));  
                ps.setString(3, fecha);
                ps.setInt(4, Integer.parseInt(id));  

                int filasActualizadas = ps.executeUpdate();
                if (filasActualizadas > 0) {
                    //Actualizar index
                    response.sendRedirect("index.jsp");
                } else {
                    response.getWriter().println("No se encontró el registro a actualizar.");
                }

                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error al actualizar el registro.");
            } finally {
                ConnMysql.cerrarConexion();
            }
        } else {
            response.getWriter().println("Error al conectar con la base de datos.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para actualizar los registros de los alumnos";
    }
}
