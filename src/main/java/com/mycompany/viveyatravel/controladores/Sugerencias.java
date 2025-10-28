package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.servicios.ConectarBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Sugerencias")
public class Sugerencias extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        if (request.getParameter("accion") != null) {
            String accion = request.getParameter("accion");
            switch (accion) {
                default:
                    request.getRequestDispatcher("./vista/sugerencias.jsp").forward(request, response);
                    break;
            }
        } else {
            registrarSugerencia(request, response);
        }
    }

    private void registrarSugerencia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String celular = request.getParameter("celular");
        String mensaje = request.getParameter("mensaje");

        String sql = "INSERT INTO sugerencias (nombres, apellidos, dni, celular, mensaje) VALUES (?, ?, ?, ?, ?)";

        ConectarBD conexion = new ConectarBD();
        try (Connection con = conexion.getConexion(); PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) {
                throw new SQLException("No se pudo establecer conexión con la base de datos.");
            }

            ps.setString(1, nombres);
            ps.setString(2, apellidos);
            ps.setString(3, dni);
            ps.setString(4, celular);
            ps.setString(5, mensaje);
            ps.executeUpdate();

            System.out.println("✅ Sugerencia registrada correctamente: " + nombres + " " + apellidos);
            response.sendRedirect("vista/sugerencias.jsp?exito=true");

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error al registrar sugerencia: " + e.getMessage());
            response.sendRedirect("vista/sugerencias.jsp?exito=false");
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
        return "Servlet para registrar sugerencias en Vive Ya Travel";
    }
}
