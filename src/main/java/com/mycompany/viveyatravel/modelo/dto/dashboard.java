package com.mycompany.viveyatravel.modelo.dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dashboard{

    private static final String URL = "jdbc:mysql://localhost:3306/viveyatravel";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Conexión exitosa a la base de datos.");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error en conexión: " + e.getMessage());
        }
        return conn;
    }
}
