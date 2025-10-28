package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class srvActualizarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("actualizar");
        if (accion != null && accion.equalsIgnoreCase("Actualizar")) {

            usuarioDAO dao = new usuarioDAO();

            try {
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String nroCelularStr = request.getParameter("nroCelular");

                int nroCelular = 0;
                if (nroCelularStr != null && !nroCelularStr.isEmpty()) {
                    nroCelular = Integer.parseInt(nroCelularStr);
                }

                usuario user = new usuario();
                user.setIdUsuario(idUsuario);
                user.setNombre(nombre);
                user.setApellido(apellido);
                user.setNroCelular(nroCelular);

                dao.actualizar(user);

                usuario clienteSesion = (usuario) request.getSession().getAttribute("cliente");
                if (clienteSesion != null) {
                    clienteSesion.setNombre(nombre);
                    clienteSesion.setApellido(apellido);
                    clienteSesion.setNroCelular(nroCelular);
                    request.getSession().setAttribute("cliente", clienteSesion);
                }

                // ✅ En lugar de reenviar al JSP, redirigimos al inicio
                response.sendRedirect(request.getContextPath() + "/index.jsp");

            } catch (SQLException e) {
                throw new ServletException("Error al actualizar usuario", e);
            } catch (NumberFormatException e) {
                request.setAttribute("mensajeError", "El número de celular no es válido.");
                request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para actualizar nombre, apellido y número de celular del usuario";
    }
}
