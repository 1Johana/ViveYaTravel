package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.ReservaDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet que muestra las reservas del usuario logueado.
 */
@WebServlet(name = "srvReserva", urlPatterns = {"/srvReserva"})
public class srvReserva extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        if (accion == null) accion = "misReservas";

        switch (accion) {
            case "misReservas":
                mostrarMisReservas(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/vista/index.jsp");
                break;
        }
    }

    /** Muestra las reservas asociadas al usuario logueado. */
    private void mostrarMisReservas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null) {
            response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
            return;
        }

        usuario cliente = (usuario) sesion.getAttribute("cliente");
        if (cliente == null) {
            response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
            return;
        }

        int idUsuario = cliente.getIdUsuario();

        ReservaDAO dao = new ReservaDAO();
        List<?> reservas = dao.listarPorUsuario(idUsuario);

        request.setAttribute("reservas", reservas);
        request.getRequestDispatcher("/vista/mis_reservas.jsp").forward(request, response);
    }

    // HTTP
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
    @Override public String getServletInfo() { return "Servlet que lista las reservas del usuario logueado"; }
}
