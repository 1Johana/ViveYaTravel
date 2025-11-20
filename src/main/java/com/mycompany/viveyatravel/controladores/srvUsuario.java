package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.ServletOutputStream;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 11 // 11 MB (un poco más para el resto del formulario)
)
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

    // ===================================
// MÉTODO processRequest (CORREGIDO)
// ===================================
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // <-- Buena práctica para tildes

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
                    case "actualizarPerfil":
                        actualizarPerfil(request, response);
                        break;
                    case "mostrarFoto":
                        mostrarFoto(request, response);
                        break;

                    // ----- 👇👇 ¡ESTA ES LA LÍNEA QUE FALTABA! 👇👇 -----
                    case "eliminarFoto":
                        eliminarFoto(request, response);
                        break;
                    // -------------------------------------------------

                    default:
                        request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msjeCredenciales", "Ocurrió un error. Intenta nuevamente.");
            request.getRequestDispatcher("/vista/iniciarSesion.jsp").forward(request, response);
        }
    }

    // =========================
    // MOSTRAR FOTO DE PERFIL
    // =========================
    // Método para mostrar la foto de perfil del usuario
    // MOSTRAR FOTO DE PERFIL (CORREGIDO)
    // =========================
    // Este método SÓLO debe servir la foto de la BD. 
    // La lógica de "mostrar avatar por defecto" va en el JSP.
    // =========================
// MOSTRAR FOTO DE PERFIL (VERSIÓN FINAL A PRUEBA DE BALAS)
// =========================
    private void mostrarFoto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        usuarioDAO dao = new usuarioDAO();

        try {
            byte[] fotoPerfil = dao.obtenerFotoPorId(idUsuario);

            if (fotoPerfil != null && fotoPerfil.length > 0) {

                // 1. Indicar el tipo de contenido (¡importante!)
                response.setContentType("image/jpeg"); // O "image/png" si guardas PNGs

                // 2. Indicar el tamaño (buena práctica)
                response.setContentLength(fotoPerfil.length);

                // 3. Obtener la "tubería" de salida
                ServletOutputStream out = response.getOutputStream();

                // 4. Escribir los bytes de la foto
                out.write(fotoPerfil);

                // 5. ¡¡LA LÍNEA MÁGICA!! 
                //    Cerrar la "tubería" para decirle al navegador "Terminé".
                out.flush();
                out.close();

            } else {
                // Si no hay foto, mandamos un error 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) { // Usamos Exception general por si acaso
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Método para obtener la imagen predeterminada según el género
    private byte[] getDefaultAvatarImage(String genero) {
        String avatarPath = "/images/default-avatar-" + genero + ".png";  // El nombre del archivo depende del género
        InputStream in = getServletContext().getResourceAsStream(avatarPath);

        try {
            if (in != null) {
                return in.readAllBytes();  // Devuelve la imagen en bytes
            } else {
                // Si no se encuentra el archivo, devuelve una imagen en blanco o error
                return new byte[0];
            }
        } catch (IOException e) {
            e.printStackTrace();
            return new byte[0];  // Devuelve un array vacío en caso de error
        }
    }

    // =========================
// ACTUALIZAR PERFIL (VERSIÓN DEFENSIVA Y ROBUSTA)
// =========================
    // =========================
// ACTUALIZAR PERFIL (VERSIÓN FINAL - LEE PARTES DE TEXTO)
// =========================
    private void actualizarPerfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- 1. DEFENSA CONTRA SESIÓN NULA ---
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cliente") == null) {
            System.out.println("DEBUG: ¡ERROR! Sesión no encontrada. Redirigiendo a login.");
            response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp?error=sesionExpirada");
            return;
        }

        usuario user = (usuario) session.getAttribute("cliente");
        // --- FIN DEFENSA DE SESIÓN ---

        try {
            // --- 2. LEER CAMPOS DE TEXTO COMO "PARTS" ---
            // (¡getParameter NO funciona con multipart/form-data!)

            String nombre = getValue(request.getPart("nombre"));
            String apellido = getValue(request.getPart("apellido"));
            String celularStr = getValue(request.getPart("nroCelular"));

            // --- 3. DEFENSA CONTRA NÚMERO INVÁLIDO ---
            int celular;
            if (celularStr != null && !celularStr.trim().isEmpty()) {
                try {
                    celular = Integer.parseInt(celularStr.trim()); // .trim() para quitar espacios
                } catch (NumberFormatException nfe) {
                    System.out.println("DEBUG: Error de formato de celular, conservando valor anterior.");
                    celular = user.getNroCelular();
                }
            } else {
                celular = user.getNroCelular();
                System.out.println("DEBUG: Celular vacío, conservando valor anterior.");
            }

            usuarioDAO dao = new usuarioDAO();

            // 4. Actualizar el objeto 'user' (ahora sí con los datos correctos)
            user.setNombre(nombre);
            user.setApellido(apellido);
            user.setNroCelular(celular);

            // 5. Lógica de la foto (esta ya estaba bien)
            Part fotoPart = request.getPart("fotoPerfil");
            if (fotoPart != null && fotoPart.getSize() > 0 && fotoPart.getInputStream() != null) {

                System.out.println("DEBUG: ¡Nueva foto detectada! Procesando...");
                InputStream fotoStream = fotoPart.getInputStream();
                java.io.ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024];

                while ((nRead = fotoStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                byte[] fotoBytes = buffer.toByteArray();

                if (fotoBytes.length > 0) {
                    user.setFotoPerfil(fotoBytes);
                }
            } else {
                System.out.println("DEBUG: No se subió una foto nueva. Se conservará la anterior.");
            }

            // 6. Guardar en la Base de Datos
            dao.actualizar(user);

            // 7. Actualizar el objeto en la sesión (¡vital!)
            request.getSession().setAttribute("cliente", user);

            // 8. Redirigir al INDEX (como pediste)
            response.sendRedirect(request.getContextPath() + "/vista/index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vista/perfil.jsp?error=true");
        }
    }

    // =========================
// =================================
// NUEVO MÉTODO: ELIMINAR FOTO DE PERFIL
// (Pega esto después de tu método 'actualizarPerfil')
// =================================
    private void eliminarFoto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificar la sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cliente") == null) {
            response.sendRedirect(request.getContextPath() + "/vista/iniciarSesion.jsp");
            return;
        }

        usuario user = (usuario) session.getAttribute("cliente");

        try {
            // 2. Poner la foto en NULL en el objeto de la sesión
            user.setFotoPerfil(null);

            // 3. REUTILIZAR tu método 'actualizar'
            // Tu DAO 'actualizar' ya sabe cómo poner NULL en la BD
            usuarioDAO dao = new usuarioDAO();
            dao.actualizar(user);

            // 4. Actualizar el objeto en la sesión (¡CRÍTICO!)
            request.getSession().setAttribute("cliente", user);

            // 5. Redirigir de vuelta al perfil
            response.sendRedirect(request.getContextPath() + "/vista/perfil.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vista/perfil.jsp?error=true");
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

    // ==============================================================
// MÉTODO AYUDANTE PARA LEER CAMPOS DE TEXTO DE UN MULTIPART/FORM-DATA
// ==============================================================
    private String getValue(Part part) throws IOException {
        if (part == null) {
            return null;
        }
        // Usamos UTF-8, el mismo que pusimos en processRequest
        BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
        StringBuilder value = new StringBuilder();
        char[] buffer = new char[1024];
        for (int length; (length = reader.read(buffer)) > 0;) {
            value.append(buffer, 0, length);
        }
        return value.toString();
    }

}
