package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.correoClave;
import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvRecuperarClave", urlPatterns = {"/srvRecuperarClave"})
public class srvRecuperarClave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        usuarioDAO dao = new usuarioDAO();
        try {
            if (action != null) {
                switch (action) {
                    case "Enlace": {
                        String correoElectronico = request.getParameter("correo");
                        // Verificamos si existe el usuario con ese correo
                        if (dao.existeUsuarioPorCorreo(correoElectronico)) {
                            // Obtener datos del usuario desde la BD
                            usuario usuarioBD = dao.obtenerPorCorreo(correoElectronico);
                            String nombre = usuarioBD.getNombre();
                            // Enviar correo
                            correoClave.enviarCorreoClave(correoElectronico, nombre);

                            //++request.setAttribute("correo", correoElectronico);
                            //++request.setAttribute("nombre", nombre);
                            request.setAttribute("mensaje", "Revisa tu correo para continuar con el cambio de contraseña.");
                            request.getRequestDispatcher("./vista/iniciarSesion.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msjeError", "No existe un usuario con ese correo.");
                            request.getRequestDispatcher("./vista/cambioClave.jsp").forward(request, response);
                        }
                        break;
                    }

                    case "cambiar": {
                        String correo = request.getParameter("correo");
                        String nuevaClave = request.getParameter("clave");

                        if (correo != null && !correo.isEmpty() && nuevaClave != null && !nuevaClave.isEmpty()) {
                            usuario u = new usuario();
                            u.setCorreoElectronico(correo);
                            u.setClave(nuevaClave);

                            dao.actualizarClave(u); // Se actualiza en la BD

                            request.setAttribute("msjeExito", "La contraseña se actualizó correctamente.");
                            request.getRequestDispatcher("./vista/iniciarSesion.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msjeError", "Datos inválidos.");
                            request.getRequestDispatcher("./vista/recuperarClave.jsp").forward(request, response);
                        }
                        break;
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error al enviar enlace de recuperación", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");

        if (correo != null && !correo.isEmpty()) {
            try {
                usuarioDAO dao = new usuarioDAO();
                usuario u = dao.obtenerPorCorreo(correo);

                if (u != null) {
                    request.setAttribute("nombre", u.getNombre());
                    request.setAttribute("correo", correo);

                    request.getRequestDispatcher("/vista/recuperarClave.jsp").forward(request, response);
                } else {
                    request.setAttribute("msjeError", "El enlace no es válido.");
                    request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
                }
            } catch (Exception e) {
                throw new ServletException("Error al cargar formulario de recuperación", e);
            }
        }
    }

}
