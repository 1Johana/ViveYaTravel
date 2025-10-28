package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class srvUsuario extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        try {
            if (accion != null) {
                switch (accion) {
                    case "verificar":
                        verificar(request, response);
                        break;
                    case "cerrar":
                        cerrarSesion(request, response);
                        break;
                    default:
                        request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // mensaje genérico
            request.setAttribute("msjeCredenciales", "Ocurrió un error. Intenta nuevamente.");
            request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
        }
    }

    // =========================
    // LOGIN (verificar)
    // =========================
    private void verificar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion;
        usuarioDAO dao = new usuarioDAO();

        // credenciales del formulario
        usuario usrReq = obtenerUsuario(request);

        // validar en BD
        usuario usrBD = dao.identificar(usrReq);

        if (usrBD != null) {
            // crear/obtener sesión
            sesion = request.getSession(true);

            // *** CLAVE PARA LAS RESERVAS ***
            // guarda el id del usuario logueado
            // (ajusta el getter si tu DTO usa otro nombre)
            sesion.setAttribute("idUsuario", usrBD.getIdUsuario());

            // guarda el objeto según el rol para tu app
            String rol = (usrBD.getCargo() != null) ? usrBD.getCargo().getNombreCargo() : "";
            if ("administrador".equalsIgnoreCase(rol)) {
                sesion.setAttribute("admin", usrBD);
                request.setAttribute("mensaje", "Bienvenido");
                request.getRequestDispatcher("/vista/ADMITours.jsp").forward(request, response);
                return;
            } else if ("cliente".equalsIgnoreCase(rol)) {
                sesion.setAttribute("cliente", usrBD);
                request.getRequestDispatcher("/vista/index.jsp").forward(request, response);
                return;
            } else {
                // rol no reconocido, pero guardar sesión igual
                sesion.setAttribute("cliente", usrBD);
                request.getRequestDispatcher("/vista/index.jsp").forward(request, response);
                return;
            }
        }

        // si llega aquí, credenciales inválidas
        request.setAttribute("msjeCredenciales", "Credenciales incorrectas");
        request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
    }

    // =========================
    // LOGOUT (cerrar)
    // =========================
    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion = request.getSession(false);
        if (sesion != null) {
            sesion.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
    }

    private usuario obtenerUsuario(HttpServletRequest request) {
        usuario u = new usuario();
        u.setCorreoElectronico(request.getParameter("correo"));
        u.setClave(request.getParameter("clave"));
        return u;
    }

    @Override
    public String getServletInfo() {
        return "Servlet de autenticación: login/logout";
    }
}
