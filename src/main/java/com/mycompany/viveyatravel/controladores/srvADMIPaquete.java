package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.PaqueteDAO;
import com.mycompany.viveyatravel.modelo.dto.Paquete;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15)   // 15MB

public class srvADMIPaquete extends HttpServlet {

    private static final String UPLOAD_DIR_NAME = "paquetes";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configuración básica
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PaqueteDAO paqdao = new PaqueteDAO();
        List<Paquete> paquetes = new ArrayList<>();
        String accion = request.getParameter("accion");
        paquetes = paqdao.lista();
        try {
            if (accion != null) {
                switch (accion) {
                    case "Registrar": {
                        // Recibir parámetros del formulario
                        String idPaquete = request.getParameter("idPaquete");
                        String nombrePaquete = request.getParameter("nombrePaquete");
                        String descripcionPaquete = request.getParameter("descripcionPaquete");
                        String precioPaquete = request.getParameter("precioPaquete");
                        String categoria = request.getParameter("categoria");
                        String detallePaquete = request.getParameter("detallePaquete");
                        // Procesar imagen (puede no venir en caso de edición)
                        Part filePart = request.getPart("imagen"); // obtiene el archivo
                        String submittedFileName = (filePart != null) ? Paths.get(filePart.getSubmittedFileName()).getFileName().toString() : "";
                        String fileName = "";

                        // Manejo de id y precio
                        int id = 0;
                        if (idPaquete != null && !idPaquete.trim().isEmpty()) {
                            try {
                                id = Integer.parseInt(idPaquete);
                            } catch (NumberFormatException ex) {
                                id = 0;
                            }
                        }
                        double precio = 0.0;
                        if (precioPaquete != null && !precioPaquete.trim().isEmpty()) {
                            try {
                                precio = Double.parseDouble(precioPaquete);
                            } catch (NumberFormatException ex) {
                                precio = 0.0;
                            }
                        }

                        // Si se subió un archivo, validarlo y guardarlo
                        if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                            String lower = submittedFileName.toLowerCase();
                            boolean allowedExt = lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                                    || lower.endsWith(".png") || lower.endsWith(".webp");
                            String contentType = (filePart.getContentType() != null) ? filePart.getContentType().toLowerCase() : "";
                            if (!allowedExt || !contentType.startsWith("image/")) {
                                // Archivo no válido
                                request.setAttribute("mensaje", "error");

                                request.setAttribute("paquetes", paqdao.lista());

                                request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                                return;

                            }

                            // a. Crear la ruta absoluta de la carpeta "paquetes"
                           // String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_NAME;
                            // a. Crear la ruta absoluta (HACK PARA GUARDAR EN EL CÓDIGO FUENTE)
                            String runtimePath = getServletContext().getRealPath(""); // Esto es C:\...\target\ViveYaTravel...
                            String projectBasePath = runtimePath.substring(0, runtimePath.indexOf("target")); // Sube hasta C:\...\ViveYaTravel\
                            String uploadPath = projectBasePath + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + UPLOAD_DIR_NAME;
                            System.out.println("Ruta REAL de subida: " + uploadPath);
                            File uploadDir = new File(uploadPath);

                            if (!uploadDir.exists()) {

                                uploadDir.mkdirs();

                            }

                            fileName = System.currentTimeMillis() + "_" + submittedFileName.replaceAll("\\s+", "_");

                            filePart.write(uploadPath + File.separator + fileName);

                        } else {

                            // Si no se subió archivo: en registro - error; en edición - mantener imagen existente
                            if (id > 0) {

                                // buscar la imagen existente del paquete
                                Paquete existing = paqdao.get(id);

                                if (existing != null) {

                                    fileName = existing.getImagen(); // mantiene imagen anterior

                                }

                            } else {

                                // No hay id y no hay archivo -> no es válido para un registro
                                request.setAttribute("mensaje", "error");

                                request.setAttribute("paquetes", paqdao.lista());

                                request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                                return;

                            }

                        }

                        // Crear objeto Paquete y setear atributos
                        Paquete p = new Paquete();

                        p.setIdPaquete(id);

                        p.setNombrePaquete(nombrePaquete);

                        p.setDescripcionPaquete(descripcionPaquete);

                        p.setPrecioPaquete(precio);

                        p.setImagen(fileName);

                        p.setCategoria(categoria);

                        p.setDetallePaquete(detallePaquete);

                        // Insertar o actualizar usando insertUpdate()
                        String resp = paqdao.insertUpdate(p);

                        // Interpretar respuesta del DAO: asumimos que resp == null o resp.trim().isEmpty() => éxito
                        boolean success = (resp == null) || (resp.trim().isEmpty());

                        paquetes = paqdao.lista();

                        request.setAttribute("paquetes", paquetes);

                        if (success) {

                            // Si id > 0 entonces fue una actualización; si id == 0 fue un registro (depende de tu DAO)
                            if (id > 0) {

                                request.setAttribute("mensaje", "actualizado");

                            } else {

                                request.setAttribute("mensaje", "registrado");

                            }

                        } else {

                            request.setAttribute("mensaje", "error");

                        }

                        request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                        break;

                    }

                    case "edit": {

                        // Cargar datos del paquete para mostrar en el formulario (no hace update aquí)
                        Integer idp = Integer.valueOf(request.getParameter("id"));

                        Paquete p = paqdao.get(idp);

                        if (p != null) {

                            request.setAttribute("idPaquete", "" + p.getIdPaquete());

                            request.setAttribute("nombrePaquete", "" + p.getNombrePaquete());

                            request.setAttribute("descripcionPaquete", "" + p.getDescripcionPaquete());

                            request.setAttribute("precioPaquete", "" + p.getPrecioPaquete());

                            request.setAttribute("imagen", "" + p.getImagen());

                            request.setAttribute("categoria", "" + p.getCategoria());

                            request.setAttribute("detallePaquete", "" + p.getDetallePaquete());

                        }

                        paquetes = paqdao.lista();

                        request.setAttribute("paquetes", paquetes);

                        // No mostrar SweetAlert en este paso (solo se carga el formulario). Si quieres, podríamos.
                        request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                        break;

                    }

                    case "delete": {

                        Integer idp = Integer.valueOf(request.getParameter("id"));

                        String resp = paqdao.delete(idp);

                        paquetes = paqdao.lista();

                        request.setAttribute("paquetes", paquetes);

                        boolean successDel = (resp == null) || (resp.trim().isEmpty());

                        if (successDel) {

                            // Intentar eliminar archivo de imagen (opcional)
                            try {

                                Paquete ex = paqdao.get(idp);

                                if (ex != null && ex.getImagen() != null && !ex.getImagen().trim().isEmpty()) {

                                    String path = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR_NAME + File.separator + ex.getImagen();

                                    File f = new File(path);

                                    if (f.exists()) {

                                        f.delete();

                                    }

                                }

                            } catch (Exception exx) {

                                // no interrumpir el flujo si falla borrar archivo
                            }

                            request.setAttribute("mensaje", "eliminado");

                        } else {

                            request.setAttribute("mensaje", "error");

                        }

                        request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                        break;

                    }

                    default:

                        // Acción desconocida: solo listar
                        paquetes = paqdao.lista();

                        request.setAttribute("paquetes", paquetes);

                        request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

                        break;

                }

            } else {

                // Sin acción: mostrar la lista
                request.setAttribute("paquetes", paquetes);

                request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

            }

        } catch (Exception ex) {

            ex.printStackTrace();

            request.setAttribute("paquetes", paqdao.lista());

            request.setAttribute("mensaje", "error");

            request.getRequestDispatcher("./vista/ADMITours.jsp").forward(request, response);

        }

    }

    // HttpServlet methods
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

        return "Servlet para administración de paquetes";

    }

}
