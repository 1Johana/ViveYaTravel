package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
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

public class srvReporteUsuarios extends HttpServlet {

    usuarioDAO usdao = new usuarioDAO();
    List<usuario> repUsuario = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OutputStream out = response.getOutputStream();
        Connection conn = null;
        repUsuario = usdao.repUsuario();
        if (request.getParameter("accion") != null) {
            String accion = request.getParameter("accion");
            switch (accion) {
                case "excel":
                    ByteArrayInputStream flujo = new usuarioDAO().exportarExcel();
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("Content-Disposition", "attachment; filename=data.xls");

                    //OutputStream out = response.getOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = flujo.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    out.flush();
                    out.close();
                    flujo.close();
                    break;
                    
                case "pdf":
                    try {
                    //Llenar el reporte con datos
                    JasperPrint jasperPrint = usdao.exportarPDF(getServletContext());
                    
                    //Configurar la respuesta HTTP
                    response.setContentType("application/pdf");
                    response.setCharacterEncoding("UTF-8");
                    response.setHeader("Content-Disposition", "inline; filename=reporte.pdf");
                    
                    //Esportar el reporte a la salida del servlet
                    JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
                } catch (JRException e) {
                    throw new ServletException(e);
                }
                    break;
            }

        } else {
            request.setAttribute("repUsuario", repUsuario);
            request.getRequestDispatcher("./vista/reporteUsuarios.jsp").forward(request, response);
        }
    }

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
        return "Short description";
    }// </editor-fold>
}
