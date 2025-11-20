package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dto.Paquete;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/srvPago")
public class srvPago extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession();

        // 1) Recuperamos carrito de sesion
        List<Paquete> carrito = (List<Paquete>) ses.getAttribute("carrito");
        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion?accion=verCarrito");
            return;
        }

        // 2) Calculamos subtotal (solo items)
        double subtotal = 0;
        for (Paquete p : carrito) {
            if (p != null) {
                subtotal += p.getSubtotal();
            }
        }

        // 3) Leemos asiento y extras del form (si vienen)
        String numeroAsiento = request.getParameter("numeroAsiento");
        String seguroStr     = request.getParameter("seguroPrecio");
        String mascotaStr    = request.getParameter("mascotaPrecio");
        String extrasStr     = request.getParameter("extrasTotal");
        String totalStr      = request.getParameter("total");

        double seguro  = parseOrZero(seguroStr);
        double mascota = parseOrZero(mascotaStr);
        double extras  = parseOrZero(extrasStr);

        double total;
        if (totalStr != null && !totalStr.trim().isEmpty()) {
            total = parseOrZero(totalStr);
        } else {
            total = subtotal + extras;
        }

        // 4) Generamos orderId simulado
        String orderId = "ORD-" + System.currentTimeMillis();

        // 5) Guardamos la compra reciente en sesión
        List<Paquete> compraReciente = new ArrayList<>(carrito);

        ses.setAttribute("compraReciente", compraReciente);
        ses.setAttribute("totalPagado", total);
        ses.setAttribute("orderId", orderId);

        // Datos para el PDF
        ses.setAttribute("pdfSubtotal", subtotal);
        ses.setAttribute("pdfExtras", extras);
        ses.setAttribute("pdfSeguro", seguro);
        ses.setAttribute("pdfMascota", mascota);
        ses.setAttribute("pdfTotal", total);
        ses.setAttribute("pdfNumeroAsiento", numeroAsiento);
        ses.setAttribute("pdfOrderId", orderId);

        // 6) Limpiamos carrito
        ses.removeAttribute("carrito");

        // 7) Redirigimos a página de confirmación
        response.sendRedirect(request.getContextPath() + "/vista/confirmacion.jsp");
    }

    private double parseOrZero(String s) {
        try {
            return (s == null || s.trim().isEmpty()) ? 0.0 : Double.parseDouble(s.trim());
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}
