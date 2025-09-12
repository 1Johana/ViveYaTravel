/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

public class srvADMIPaquete extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
         //crear el objeto paqDAO dentro de PaqueteDAO
        PaqueteDAO paqdao = new PaqueteDAO();
        List<Paquete> paquetes = new ArrayList<>();

        String accion = request.getParameter("accion");
        paquetes = paqdao.lista();
        if (accion != null) {
            switch (accion) {
                case "Registrar": {
                    //Recibir parámetros del formulario
                    String idPaquete = request.getParameter("idPaquete");
                    String nombrePaquete = request.getParameter("nombrePaquete");
                    String descripcionPaquete = request.getParameter("descripcionPaquete");
                    String precioPaquete = request.getParameter("precioPaquete");
                    String imagen = request.getParameter("imagen");
                    String categoria = request.getParameter("categoria");
                    String detallePaquete = request.getParameter("detallePaquete");

                    
                    // Validar y convertir idPaquete a entero
                int id = 0; // Valor por defecto o manejo de error
                if (!idPaquete.isEmpty()) {
                    id = Integer.parseInt(idPaquete);
                }

                // Validar y convertir precioPaquete a double
                double precio = 0.0; // Valor por defecto o manejo de error
                if (!precioPaquete.isEmpty()) {
                    precio = Double.parseDouble(precioPaquete);
                }

                    //crear el objeto Paquete y establecer sus atributos
                    Paquete p = new Paquete();                    
                    //request.setAttribute("paquetes", paquetes);}
                    p.setIdPaquete(id);
                    p.setNombrePaquete(nombrePaquete);
                    p.setDescripcionPaquete(descripcionPaquete);
                    p.setPrecioPaquete(precio);
                    p.setImagen(imagen);
                    p.setCategoria(categoria);
                    p.setDetallePaquete(detallePaquete);

                    //Insertar la sugerencia en la BD por el modelo DAO
                    String resp = paqdao.insertUpdate(p);

                    // Obtener la lista actualizada de paquetes
                    paquetes = paqdao.lista();
                    request.setAttribute("paquetes", paquetes);
                    request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);
                    break;
                }

                case "edit": {
                    Integer idp = Integer.valueOf(request.getParameter("id"));
                    Paquete p = paqdao.get(idp);
                    // Establecer atributos en el request para pasar al JSP de edición
                    request.setAttribute("idPaquete", "" + p.getIdPaquete());
                    request.setAttribute("nombrePaquete", "" + p.getNombrePaquete());
                    request.setAttribute("descripcionPaquete", "" + p.getDescripcionPaquete());
                    request.setAttribute("precioPaquete", "" + p.getPrecioPaquete());
                    request.setAttribute("imagen", "" + p.getImagen());
                    request.setAttribute("categoria", "" + p.getCategoria());
                    request.setAttribute("detallePaquete", "" + p.getDetallePaquete());
                    request.setAttribute("paquetes", paquetes);

                    // Obtener la lista actualizada de paquetes
                    paquetes = paqdao.lista();
                    request.setAttribute("paquetes", paquetes);
                    request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);
                    break;
                }
                case "delete": {
                    Integer idp = Integer.valueOf(request.getParameter("id"));
                    String resp = paqdao.delete(idp);
                    // Manejar el resultado del borrado
                    request.setAttribute("mensaje", resp);
                    if (resp.trim().isEmpty()) {
                        request.setAttribute("result", "info");
                    } else {
                        request.setAttribute("result", "error");
                    }           // Actualizar la lista y redirigir a la página de administración
                    paquetes = paqdao.lista();
                    request.setAttribute("paquetes", paquetes);
                    request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);
                    break;
                }
                default:
                    break;
            }
 
        } else {
             //En caso no haya ninguna acción se ejecutan estos comandos
            request.setAttribute("paquetes", paquetes);
            request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);
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
