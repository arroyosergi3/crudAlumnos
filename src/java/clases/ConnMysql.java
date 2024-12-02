/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author alex
 */
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConnMysql {

    // Propiedades
    private static Connection conn = null;
    private String driver;
    private String url;
    private String usuario;
    private String password;

    // Constructor
    public ConnMysql() {

        String url = "jdbc:mysql://localhost:3306/crud?autoReconnect=true&useSSL=false";
        String driver = "com.mysql.jdbc.Driver";
        String usuario = "dwes";
        String password = "abc123.";

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, usuario, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    } // Fin constructor

    // Métodos
    public Connection getConnection() {

        return conn;
    } // Fin getConnection

    public static void cerrarConexion() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConnMysql.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
