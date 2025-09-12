package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

public class srvReportePDF extends HttpServlet {
    private static final long serialVersionUID = 1L;

    usuarioDAO usdao = new usuarioDAO();
    List<usuario> repUsuario = new ArrayList<>();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        if ("pdf".equals(accion)) {
            InputStream jrxmlStream = null;
            ServletOutputStream servletOutputStream = null;

            try {
                // Ruta al archivo JRXML
                String jrxmlFilePath = "/reporteJasper/usuarios1.jrxml";  // Ruta al archivo .jrxml
                jrxmlStream = getServletContext().getResourceAsStream(jrxmlFilePath);

                if (jrxmlStream == null) {
                    throw new ServletException("Archivo JRXML no encontrado en la ruta especificada: " + jrxmlFilePath);
                }

                // Compilar el archivo JRXML a JasperReport
                JasperReport jasperReport = JasperCompileManager.compileReport(jrxmlStream);

                // Configurar la respuesta HTTP
                response.setContentType("application/pdf");
                response.setCharacterEncoding("UTF-8");
                response.setHeader("Content-Disposition", "inline; filename=reporte.pdf");

                servletOutputStream = response.getOutputStream();

                // Generar el reporte PDF
                JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), new JREmptyDataSource());
                JasperExportManager.exportReportToPdfStream(jasperPrint, servletOutputStream);

            } catch (JRException e) {
                throw new ServletException("Error al generar el reporte PDF", e);
            } finally {
                // Cerrar flujos de entrada y salida
                if (jrxmlStream != null) {
                    try {
                        jrxmlStream.close();
                    } catch (IOException e) {
                        // Manejo de errores al cerrar el flujo de entrada
                        e.printStackTrace();
                    }
                }
                if (servletOutputStream != null) {
                    try {
                        servletOutputStream.flush();
                        servletOutputStream.close();
                    } catch (IOException e) {
                        // Manejo de errores al cerrar el flujo de salida del servlet
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
