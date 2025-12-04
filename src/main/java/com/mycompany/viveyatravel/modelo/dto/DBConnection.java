package com.mycompany.viveyatravel.modelo.dto;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/bdagenciadeviajes?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✔ Conexión exitosa a MySQL");
        } catch (Exception e) {
            System.out.println("❌ Error en conexión: " + e.getMessage());
        }

        return conn;
    }
}

