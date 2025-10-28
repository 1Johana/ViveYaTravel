package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.AsientoDAO;
import com.mycompany.viveyatravel.modelo.dao.PaqueteDAO;
import com.mycompany.viveyatravel.modelo.dao.ReservaDAO;
import com.mycompany.viveyatravel.modelo.dto.Asiento;
import com.mycompany.viveyatravel.modelo.dto.Paquete;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

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
                case "verAsientos":
                    verAsientos(request, response);
                    break;
                case "seleccionarAsiento":
                    seleccionarAsiento(request, response);
                    break;
                case "confirmarPago":
                    confirmarPago(request, response);
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
        if (carrito == null) carrito = new ArrayList<>();

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

    // ================================
    // 🚍 SELECCIÓN DE ASIENTOS
    // ================================
    private void verAsientos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idPaqueteStr = request.getParameter("idPaquete");
            if (idPaqueteStr == null || idPaqueteStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/srvPromocion");
                return;
            }
            int idPaquete = Integer.parseInt(idPaqueteStr);

            int idBus = 1; // ajustar si luego tienes un idBus real

            Paquete p = paqdao.get(idPaquete);
            if (p != null) {
                request.setAttribute("precioPaquete", p.getPrecioPaquete());
                request.setAttribute("nombrePaquete", p.getNombrePaquete());
            }

            AsientoDAO adao = new AsientoDAO();
            List<Asiento> lista = adao.listarPorBus(idBus);

            request.setAttribute("asientos", lista);
            request.setAttribute("idPaquete", idPaquete);
            request.setAttribute("idBus", idBus);

            request.getRequestDispatcher("/vista/seleccionarAsiento.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
        }
    }

    @SuppressWarnings("unchecked")
    private void seleccionarAsiento(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int idAsiento = Integer.parseInt(request.getParameter("idAsiento"));
            int idBus = Integer.parseInt(request.getParameter("idBus"));
            int idPaquete = Integer.parseInt(request.getParameter("idPaquete"));

            request.getSession().setAttribute("idAsiento", idAsiento);
            request.getSession().setAttribute("idBus", idBus);

            AsientoDAO adao = new AsientoDAO();
            Asiento asiento = adao.obtener(idAsiento);
            if (asiento != null) {
                request.getSession().setAttribute("numeroAsiento", asiento.getNumeroAsiento());
            }

            Paquete paquete = paqdao.get(idPaquete);
            if (paquete != null) {
                List<Paquete> carrito = (List<Paquete>) request.getSession().getAttribute("carrito");
                if (carrito == null) carrito = new ArrayList<>();

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
            }

            response.sendRedirect(request.getContextPath() + "/vista/pago.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
        }
    }

    // =====================================================
    // ✅ CONFIRMAR PAGO — ocupa asiento + persiste reserva
    // =====================================================
    private void confirmarPago(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            // a) idAsiento (del form; si falta, de sesión)
            Integer idAsiento = null;
            try { idAsiento = Integer.valueOf(request.getParameter("idAsiento")); } catch (Exception ignored) {}
            if (idAsiento == null || idAsiento == 0) {
                Object obj = request.getSession().getAttribute("idAsiento");
                if (obj instanceof Integer) idAsiento = (Integer) obj;
            }

            // b) idPaquete del form
            Integer idPaquete = null;
            try { idPaquete = Integer.valueOf(request.getParameter("idPaquete")); } catch (Exception ignored) {}

            // c) numeroAsiento del form -> pásalo a la vista y a sesión
            String numeroAsiento = request.getParameter("numeroAsiento");
            if (numeroAsiento != null && !numeroAsiento.isEmpty()) {
                request.setAttribute("numeroAsiento", numeroAsiento);
                request.getSession().setAttribute("numeroAsiento", numeroAsiento);
            }

            // d) totales
            double subtotal = parseDoubleSafe(request.getParameter("subtotal"));
            double extras   = parseDoubleSafe(request.getParameter("extrasTotal"));
            double seguro   = parseDoubleSafe(request.getParameter("seguroPrecio"));
            double mascota  = parseDoubleSafe(request.getParameter("mascotaPrecio"));
            double total    = parseDoubleSafe(request.getParameter("total"));
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("extras", extras);
            request.setAttribute("seguro", seguro);
            request.setAttribute("mascota", mascota);
            request.setAttribute("total", total);

            // nombre paquete (para la confirmación)
            if (idPaquete != null) {
                Paquete px = paqdao.get(idPaquete);
                if (px != null) request.setAttribute("nombrePaquete", px.getNombrePaquete());
            }

            // si no hay asiento -> ir a confirmación con error
            if (idAsiento == null || idAsiento == 0) {
                request.setAttribute("ok", false);
                request.setAttribute("mensaje", "No se detectó asiento seleccionado.");
                request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                return;
            }

            // e) ocupar asiento
            AsientoDAO adao = new AsientoDAO();
            boolean ocupado = adao.ocuparAsiento(idAsiento);
            if (!ocupado) {
                request.setAttribute("ok", false);
                request.setAttribute("mensaje", "El asiento ya fue ocupado, elige otro.");
                request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                return;
            }

            // f) obtener idUsuario desde la sesión (varios posibles atributos)
            Integer idUsuario = null;
            HttpSession ses = request.getSession(false);
            if (ses != null) {
                Object o1 = ses.getAttribute("idUsuario");
                if (o1 instanceof Integer) idUsuario = (Integer) o1;

                if (idUsuario == null) {
                    Object u = ses.getAttribute("usuario");
                    if (u != null) {
                        try {
                            java.lang.reflect.Method m = u.getClass().getMethod("getIdUsuario");
                            Object v = m.invoke(u);
                            if (v instanceof Number) idUsuario = ((Number) v).intValue();
                        } catch (NoSuchMethodException ns) {
                            try {
                                java.lang.reflect.Method m = u.getClass().getMethod("getIdCliente");
                                Object v = m.invoke(u);
                                if (v instanceof Number) idUsuario = ((Number) v).intValue();
                            } catch (Exception ignore) {}
                        } catch (Exception ignore) {}
                    }
                }

                if (idUsuario == null) {
                    Object c = ses.getAttribute("cliente");
                    if (c != null) {
                        try {
                            java.lang.reflect.Method m = c.getClass().getMethod("getIdCliente");
                            Object v = m.invoke(c);
                            if (v instanceof Number) idUsuario = ((Number) v).intValue();
                        } catch (Exception ignore) {}
                    }
                }
            }

            // g) persistir reserva (si hay usuario y paquete)
            if (idUsuario != null && idUsuario > 0 && idPaquete != null && idPaquete > 0) {
                ReservaDAO rdao = new ReservaDAO();
                int idReserva = rdao.crear(idUsuario, idPaquete, idAsiento, "PAGADO");
                if (idReserva > 0) {
                    request.setAttribute("idReserva", idReserva);
                }
            }

            request.setAttribute("ok", true);
            request.setAttribute("mensaje", "¡Pago confirmado! Asiento reservado correctamente.");
            request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
        }
    }

    private double parseDoubleSafe(String s) {
        try { return (s == null || s.isEmpty()) ? 0.0 : Double.parseDouble(s); }
        catch (Exception e) { return 0.0; }
    }

    // =====================================================

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
        return "Servlet para promociones, carrito y selección de asientos";
    }
}
