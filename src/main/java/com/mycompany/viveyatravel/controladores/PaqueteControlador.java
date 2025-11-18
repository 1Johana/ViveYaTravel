package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.PaqueteDAO;
import com.mycompany.viveyatravel.modelo.dto.Paquete;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaqueteControlador extends HttpServlet {

    PaqueteDAO paqdao = new PaqueteDAO();

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- 1. Leer los parámetros de filtro ---
        // Si vienen nulos o vacíos, se usarán como null
        String accion = request.getParameter("accion");
        String filtroNombre = request.getParameter("nombre");
        String filtroPrecio = request.getParameter("precio");
        String filtroOrden = request.getParameter("orden");

        if (accion != null) {
            switch (accion) {
                case "verDetalle":
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Paquete detalle = paqdao.obtenerDetalle(id);
                        request.setAttribute("detalle", detalle);
                        request.getRequestDispatcher("./vista/detalleTours.jsp").forward(request, response);
                    } catch (NumberFormatException e) {
                        response.sendRedirect("error.jsp");
                    }
                    break;
                // Aquí podrías tener más acciones
            }
        } else {
            // --- 2. Esta es la acción por defecto (cargar la lista de tours) ---
            
            // Llama al DAO con los filtros (pueden ser null)
            List<Paquete> lista = paqdao.listar(filtroNombre, filtroPrecio, filtroOrden); 
            
            // --- 3. Devolver los filtros al JSP (para "recordar" la selección) ---
            request.setAttribute("filtroNombre", filtroNombre);
            request.setAttribute("filtroPrecio", filtroPrecio);
            request.setAttribute("filtroOrden", filtroOrden);

            // Enviar la lista (filtrada o completa) a la vista
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("./vista/tours.jsp").forward(request, response);
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
