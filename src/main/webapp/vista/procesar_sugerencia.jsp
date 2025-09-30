<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.viveyatravel.servicios.ConectarBD"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>

<%
    response.setContentType("text/plain");

    String nombres = request.getParameter("nombre");
    String apellidos = request.getParameter("apellido");
    String dni = request.getParameter("dni");
    String numero = request.getParameter("numero");
    String mensaje = request.getParameter("mensaje");

    Connection cnx = null;
    PreparedStatement ps = null;
    
    try {
        ConectarBD connBD = new ConectarBD();
        cnx = connBD.getConexion();
        
        if (cnx != null) {
            String sql = "INSERT INTO sugerencias (nombres, apellidos, dni, numero_contacto, mensaje) VALUES (?, ?, ?, ?, ?)";
            ps = cnx.prepareStatement(sql);
            ps.setString(1, nombres);
            ps.setString(2, apellidos);
            ps.setString(3, dni);
            ps.setString(4, numero);
            ps.setString(5, mensaje);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                out.print("success");
            } else {
                out.print("error");
            }
        } else {
            out.print("error");
        }
    } catch (SQLException ex) {
        ex.printStackTrace(System.out);
        out.print("error");
    } finally {
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) {}
        }
        if (cnx != null) {
            try { cnx.close(); } catch (SQLException e) {}
        }
    }
%>