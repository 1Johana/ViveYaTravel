package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.PaqueteDAO;
import com.mycompany.viveyatravel.modelo.dto.Paquete;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class srvPromocion extends HttpServlet {

    private static final long serialVersionUID = 1L;
    PaqueteDAO paqdao = new PaqueteDAO();
    List<Paquete> promociones = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "agregar":
                    agregarAlCarrito(request, response);
                    break;
                case "eliminar":
                    eliminarDelCarrito(request, response);
                    break;
                case "verCarrito":
                    request.getRequestDispatcher("/vista/car.jsp").forward(request, response);
                    break;
                default:
                    listarPromociones(request, response);
            }
        } else {
            listarPromociones(request, response);
        }
    }

    private void listarPromociones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        promociones = paqdao.list();
        request.setAttribute("promociones", promociones);
        request.getRequestDispatcher("/vista/promociones.jsp").forward(request, response);
    }

    @SuppressWarnings("unchecked")
    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idPaquete");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
            return;
        }

        int idPaquete;
        try {
            idPaquete = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
            return;
        }

        Paquete paquete = paqdao.get(idPaquete);
        if (paquete == null) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
            return;
        }

        List<Paquete> carrito = (List<Paquete>) request.getSession().getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        boolean existe = false;
        for (Paquete p : carrito) {
            if (p.getIdPaquete() == paquete.getIdPaquete()) {
                p.setCantidad(p.getCantidad() + 1);
                existe = true;
                break;
            }
        }

        if (!existe) {
            paquete.setCantidad(1);
            carrito.add(paquete);
        }

        request.getSession().setAttribute("carrito", carrito);
        response.sendRedirect(request.getContextPath() + "/srvPromocion?accion=verCarrito");
    }

    @SuppressWarnings("unchecked")
    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idPaquete");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion?accion=verCarrito");
            return;
        }

        int idPaquete = Integer.parseInt(idStr);
        List<Paquete> carrito = (List<Paquete>) request.getSession().getAttribute("carrito");

        if (carrito != null) {
            Iterator<Paquete> it = carrito.iterator();
            while (it.hasNext()) {
                Paquete p = it.next();
                if (p.getIdPaquete() == idPaquete) {
                    it.remove();
                    break;
                }
            }
            request.getSession().setAttribute("carrito", carrito);
        }

        response.sendRedirect(request.getContextPath() + "/srvPromocion?accion=verCarrito");
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
        return "Servlet para promociones y carrito";
    }
}
