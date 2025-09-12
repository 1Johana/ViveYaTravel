package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class srvActualizarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("actualizar");
        if (accion != null) {
            if (accion.equals("Actualizar")) {
                usuarioDAO dao;
                dao = new usuarioDAO();
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                int nroCelular = Integer.parseInt(request.getParameter("nroCelular"));
                int nroDni = Integer.parseInt(request.getParameter("nroDni"));
                String correoElectronico = request.getParameter("correoElectronico");
                String clave = request.getParameter("clave");

                usuario user = new usuario();
                user.setIdUsuario(idUsuario);
                user.setNombre(nombre);
                user.setApellido(apellido);
                user.setNroCelular(nroCelular);
                user.setNroDni(nroDni);
                user.setCorreoElectronico(correoElectronico);
                user.setClave(clave);

                try {
                    dao.actualizar(user);
                    request.getSession().setAttribute("cliente", user);
                    this.getServletConfig().getServletContext().getRequestDispatcher("/vista/index.jsp").forward(request, response);
                } catch (SQLException e) {
                    throw new ServletException("Error actualizando usuario", e);
                }

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
