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

@WebServlet("/srvPago")
public class srvPago extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recuperamos carrito de sesion
        List<Paquete> carrito = (List<Paquete>) request.getSession().getAttribute("carrito");
        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/srvPromocion?accion=verCarrito");
            return;
        }

        // Calculamos subtotal
        double subtotal = 0;
        for (Paquete p : carrito) {
            subtotal += p.getSubtotal();
        }

        // Generamos orderId simulado
        String orderId = "ORD-" + System.currentTimeMillis();

        // Guardamos la compra reciente en sesión (copia) para mostrar en confirmacion
        List<Paquete> compraReciente = new ArrayList<>();
        compraReciente.addAll(carrito);

        request.getSession().setAttribute("compraReciente", compraReciente);
        request.getSession().setAttribute("totalPagado", subtotal);
        request.getSession().setAttribute("orderId", orderId);

        // Limpiamos carrito
        request.getSession().removeAttribute("carrito");

        // Redirigimos a página de confirmación
        response.sendRedirect(request.getContextPath() + "/vista/confirmacion.jsp");
    }
}
