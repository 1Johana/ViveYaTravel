package com.mycompany.viveyatravel.controladores;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvEliminarUsuario", urlPatterns = {"/srvEliminarUsuario"})
public class srvEliminarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("eliminar");

        if ("Eliminar".equals(accion)) {
            try {
                String idStr = request.getParameter("idUsuario");
                if (idStr == null || idStr.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/vista/error.jsp");
                    return;
                }

                int idUsuario = Integer.parseInt(idStr);

                usuario user = new usuario();
                user.setIdUsuario(idUsuario);

                usuarioDAO dao = new usuarioDAO();

                if (dao.eliminar(user)) {
                    request.getSession().invalidate(); // cerrar sesión
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/vista/error.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/vista/error.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
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
        return "Servlet para eliminar un usuario y cerrar sesión";
    }
}