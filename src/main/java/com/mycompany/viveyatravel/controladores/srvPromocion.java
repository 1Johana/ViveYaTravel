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

    // =====================================================
    // ENRUTADOR PRINCIPAL
    // =====================================================
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

    // =====================================================
    // LISTAR PROMOCIONES (con filtros)
    // =====================================================
    private void listarPromociones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Leer filtros desde la request
        String filtroNombre = request.getParameter("nombre");
        String filtroPrecio = request.getParameter("precio");
        String filtroOrden  = request.getParameter("orden");

        // 2. Llamar al DAO (pueden ser null)
        List<Paquete> promociones = paqdao.list(filtroNombre, filtroPrecio, filtroOrden);

        // 3. Devolver filtros al JSP
        request.setAttribute("filtroNombre", filtroNombre);
        request.setAttribute("filtroPrecio", filtroPrecio);
        request.setAttribute("filtroOrden", filtroOrden);

        // 4. Enviar lista
        request.setAttribute("promociones", promociones);
        request.getRequestDispatcher("/vista/promociones.jsp").forward(request, response);
    }

    // =====================================================
    // CARRITO: AGREGAR
    // =====================================================
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

    // =====================================================
    // CARRITO: ELIMINAR
    // =====================================================
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

    // =====================================================
    // VER ASIENTOS PARA UN PAQUETE
    // =====================================================
    private void verAsientos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idPaqueteStr = request.getParameter("idPaquete");
            if (idPaqueteStr == null || idPaqueteStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/srvPromocion");
                return;
            }
            int idPaquete = Integer.parseInt(idPaqueteStr);

            // Por ahora: truco -> un solo bus (idBus = 1) salvo que luego mandes otro idBus por parámetro
            int idBus = 1;
            String idBusStr = request.getParameter("idBus");
            if (idBusStr != null && !idBusStr.trim().isEmpty()) {
                try {
                    idBus = Integer.parseInt(idBusStr.trim());
                } catch (NumberFormatException ignored) {}
            }

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

    // =====================================================
    // SELECCIONAR ASIENTO (VERSIÓN ANTIGUA - 1 asiento)
    // =====================================================
    @SuppressWarnings("unchecked")
    private void seleccionarAsiento(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int idAsiento = Integer.parseInt(request.getParameter("idAsiento"));
            int idBus     = Integer.parseInt(request.getParameter("idBus"));
            int idPaquete = Integer.parseInt(request.getParameter("idPaquete"));

            request.getSession().setAttribute("idAsiento", idAsiento);
            request.getSession().setAttribute("idBus", idBus);

            AsientoDAO adao = new AsientoDAO();
            Asiento asiento = adao.obtener(idAsiento);
            if (asiento != null) {
                // En tu JSP usas a.getNumero(), así que aquí lo más seguro es getNumero()
                request.getSession().setAttribute("numeroAsiento", asiento.getNumero());
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

            // Flujo antiguo: te manda a pago.jsp
            response.sendRedirect(request.getContextPath() + "/vista/pago.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
        }
    }

    // =====================================================
    // ✅ CONFIRMAR PAGO — MULTIASIENTOS / MULTIPASAJEROS
    // =====================================================
    private void confirmarPago(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            HttpSession ses = request.getSession(false);

            // 1) Leer idAsiento como CSV: "12,14,15" (nuevo flujo)
            String idsAsientosCSV = request.getParameter("idAsiento");

            // Si viene vacío, intentamos compat con flujo antiguo (un solo asiento en sesión)
            if ((idsAsientosCSV == null || idsAsientosCSV.trim().isEmpty()) && ses != null) {
                Object obj = ses.getAttribute("idAsiento");
                if (obj != null) {
                    idsAsientosCSV = String.valueOf(obj); // ej. "12"
                }
            }

            if (idsAsientosCSV == null || idsAsientosCSV.trim().isEmpty()) {
                request.setAttribute("ok", false);
                request.setAttribute("mensaje", "No se detectaron asientos seleccionados.");
                request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                return;
            }

            String[] tokens = idsAsientosCSV.split(",");
            List<Integer> idAsientos = new ArrayList<>();
            for (String t : tokens) {
                if (t == null) continue;
                t = t.trim();
                if (t.isEmpty()) continue;
                try {
                    idAsientos.add(Integer.parseInt(t));
                } catch (NumberFormatException ignored) {}
            }

            if (idAsientos.isEmpty()) {
                request.setAttribute("ok", false);
                request.setAttribute("mensaje", "Los asientos enviados no son válidos.");
                request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                return;
            }

            // 2) Números de asiento (solo para mostrar en la confirmación)
            String numerosAsientosCSV = request.getParameter("numeroAsiento");
            if (numerosAsientosCSV != null && !numerosAsientosCSV.trim().isEmpty()) {
                request.setAttribute("numeroAsiento", numerosAsientosCSV);
                if (ses != null) {
                    ses.setAttribute("numeroAsiento", numerosAsientosCSV);
                }
            }

            // 3) Cantidad de pasajeros
            int cantidadPasajeros = 1;
            String cantStr = request.getParameter("cantidadPasajeros");
            if (cantStr != null && !cantStr.isEmpty()) {
                try {
                    cantidadPasajeros = Integer.parseInt(cantStr);
                } catch (NumberFormatException ignored) {}
            }
            request.setAttribute("cantidadPasajeros", cantidadPasajeros);

            // Solo validamos estrictamente si el JSP mandó cantidadPasajeros
            if (cantStr != null && !cantStr.isEmpty()) {
                if (cantidadPasajeros > 0 && idAsientos.size() != cantidadPasajeros) {
                    request.setAttribute("ok", false);
                    request.setAttribute("mensaje",
                            "La cantidad de asientos seleccionados no coincide con la cantidad de pasajeros.");
                    request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                    return;
                }
            }

            // 4) idPaquete
            Integer idPaquete = null;
            try {
                idPaquete = Integer.valueOf(request.getParameter("idPaquete"));
            } catch (Exception ignored) {}

            // 5) Totales
            double subtotal = parseDoubleSafe(request.getParameter("subtotal"));
            double extras   = parseDoubleSafe(request.getParameter("extrasTotal"));
            double seguro   = parseDoubleSafe(request.getParameter("seguroPrecio"));
            double mascota  = parseDoubleSafe(request.getParameter("mascotaPrecio"));
            double total    = parseDoubleSafe(request.getParameter("total"));

            request.setAttribute("subtotal", subtotal);
            request.setAttribute("extras",   extras);
            request.setAttribute("seguro",   seguro);
            request.setAttribute("mascota",  mascota);
            request.setAttribute("total",    total);

            // Nombre del paquete
            if (idPaquete != null) {
                Paquete px = paqdao.get(idPaquete);
                if (px != null) {
                    request.setAttribute("nombrePaquete", px.getNombrePaquete());
                }
            }

            // 6) Obtener idUsuario desde la sesión
            Integer idUsuario = null;
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

            // 7) Ocupar asientos + crear reservas
            AsientoDAO adao = new AsientoDAO();
            ReservaDAO rdao = new ReservaDAO();
            List<Integer> reservasCreadas = new ArrayList<>();

            for (Integer idAsiento : idAsientos) {
                if (idAsiento == null || idAsiento <= 0) continue;

                boolean ocupado = adao.ocuparAsiento(idAsiento);
                if (!ocupado) {
                    request.setAttribute("ok", false);
                    request.setAttribute("mensaje",
                            "Uno de los asientos seleccionados ya fue ocupado. Por favor, vuelve a elegir.");
                    request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);
                    return;
                }

                if (idUsuario != null && idUsuario > 0 && idPaquete != null && idPaquete > 0) {
                    int idReserva = rdao.crear(idUsuario, idPaquete, idAsiento, "PAGADO");
                    if (idReserva > 0) {
                        reservasCreadas.add(idReserva);
                    }
                }
            }

            if (!reservasCreadas.isEmpty()) {
                // Para compatibilidad con vistas que solo muestran una
                request.setAttribute("idReserva", reservasCreadas.get(0));
                // Y también todas (por si luego quieres mostrarlas)
                request.setAttribute("reservasIds", reservasCreadas);
            }

            request.setAttribute("ok", true);
            request.setAttribute("mensaje",
                    "¡Pago confirmado! Se han reservado " + idAsientos.size() + " asiento(s) correctamente.");
            request.getRequestDispatcher("/vista/confirmacion.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/srvPromocion");
        }
    }

    // =====================================================
    // Utilidad para parsear double sin romper
    // =====================================================
    private double parseDoubleSafe(String s) {
        try {
            return (s == null || s.isEmpty()) ? 0.0 : Double.parseDouble(s);
        } catch (Exception e) {
            return 0.0;
        }
    }

    // =====================================================
    // MÉTODOS HTTP
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
        return "Servlet para promociones, carrito, selección de asientos y pago (multi-pasajero)";
    }
}
