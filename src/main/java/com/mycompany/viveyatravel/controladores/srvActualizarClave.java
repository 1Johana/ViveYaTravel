package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.util.HashUtil;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvActualizarClave", urlPatterns = {"/srvActualizarClave"})
public class srvActualizarClave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correoElectronico");
        String claveActual = request.getParameter("claveActual");
        String nuevaClave = request.getParameter("claveNueva");
        String repetirClave = request.getParameter("claveRepetir");

        // Validar campos vacíos
        if (correo == null || claveActual == null || nuevaClave == null || repetirClave == null
                || correo.isEmpty() || claveActual.isEmpty() || nuevaClave.isEmpty() || repetirClave.isEmpty()) {

            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
            return;
        }

        // Validar coincidencia de contraseñas
        if (!nuevaClave.equals(repetirClave)) {
            request.setAttribute("error", "Las contraseñas nuevas no coinciden.");
            request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
            return;
        }

        // Validar complejidad de la nueva contraseña
        if (nuevaClave.length() < 8 || !nuevaClave.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            request.setAttribute("error", "La nueva contraseña debe tener al menos 8 caracteres y un carácter especial.");
            request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
            return;
        }

        try {
            usuarioDAO dao = new usuarioDAO();
            usuario u = dao.obtenerPorCorreo(correo);

            if (u == null) {
                request.setAttribute("error", "Usuario no encontrado.");
                request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
                return;
            }

            // Verificar si la contraseña actual es correcta
            if (!HashUtil.hashPassword(claveActual).equals(u.getClave())) {
                request.setAttribute("error", "La contraseña actual no es correcta.");
                request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
                return;
            }

            // ✅ Actualizar clave (el DAO se encarga de encriptarla)
            u.setClave(nuevaClave);
            dao.actualizarClave(u);

            request.setAttribute("exito", "Tu contraseña fue actualizada correctamente.");
            request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Error al actualizar contraseña: " + e.getMessage());
            request.getRequestDispatcher("/vista/perfil.jsp").forward(request, response);
        }
    }
}
