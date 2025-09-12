package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.correo;
import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvRegistroUsuario", urlPatterns = {"/srvRegistroUsuario"})   //Definicion del nombre del servlet y la url de como acceder

public class srvRegistroUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); //Para que pueda insertar caracteres especiales
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("registrar");  //Obtiene el valor de registrar de la solicitud

        if (accion != null) { //Si la accion no es nula
            if (accion.equals("Registrarte")) {  //Si la accion es igual a Registrarte realiza el bloque de codigo
                //Se obtiene los valores del formulario
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String nroCelularStr = request.getParameter("nroCelular");
                String nroDniStr = request.getParameter("nroDni");
                String correoElectronico = request.getParameter("correoElectronico");
                String clave = request.getParameter("clave");

                //Convierte la cadena de texto a enteros, el nroCelular y el DNI
                int nroCelular = 0;
                if (nroCelularStr != null && !nroCelularStr.isEmpty()) {
                    nroCelular = Integer.parseInt(nroCelularStr);
                }

                int nroDni = 0;
                if (nroDniStr != null && !nroDniStr.isEmpty()) {
                    nroDni = Integer.parseInt(nroDniStr);
                }

                usuario usuario = new usuario();  //Se instancia el objeto usuario
                usuario.setNombre(nombre);
                usuario.setApellido(apellido);
                usuario.setNroCelular(nroCelular);
                usuario.setNroDni(nroDni);
                usuario.setCorreoElectronico(correoElectronico);
                usuario.setClave(clave);

                //inserción en la base de datos
                usuarioDAO usuarioDAO = new usuarioDAO();

                try {
                    boolean existe = usuarioDAO.existeUsuarioPorDni(nroDni);
                    boolean existeCorreo = usuarioDAO.existeUsuarioPorCorreo(correoElectronico);

                    if (!existe) {
                        if (!existeCorreo) {
                            usuarioDAO.registrar(usuario);
                            correo.enviarCorreoBienvenida(correoElectronico, nombre);
                            // Redireccionar una vez el registro fue exitoso
                            response.sendRedirect("./vista/iniciarSesion.jsp?registro=exito");
                        } else {
                            response.sendRedirect("./vista/registrar.jsp?registro=correo");
                        }
                    } else {
                        response.sendRedirect("./vista/registrar.jsp?registro=dni");
                    }
                    // Registra el usuario en la base de datos

                } catch (Exception ex) {
                    // En caso de error
                    response.sendRedirect("error.jsp");
                }
            }
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
