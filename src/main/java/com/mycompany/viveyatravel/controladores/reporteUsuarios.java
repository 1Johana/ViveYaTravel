package com.mycompany.viveyatravel.controladores;

import com.mycompany.viveyatravel.modelo.dao.usuarioDAO;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanArrayDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

public class reporteUsuarios extends HttpServlet {

    usuarioDAO usdao = new usuarioDAO();
    List<usuario> repUsuario = new ArrayList<>();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        repUsuario = usdao.repUsuario();
        if (request.getParameter("accion") != null) {
            String accion = request.getParameter("accion");
            switch (accion) {
                case "exportarReporteUsuarios":
                    this.exportarReporteUsuarios(request, response);
                    break;
            }

        } else {
            request.setAttribute("repUsuario", repUsuario);
            request.getRequestDispatcher("./vista/reporteUsuarios.jsp").forward(request, response);
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

    private void exportarReporteUsuarios(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        ServletOutputStream out = response.getOutputStream();
        try {
            InputStream logo = this.getServletConfig()
                    .getServletContext()
                    .getResourceAsStream("reporteJasper/img/logo.png"),
                    reporteUsuario = this.getServletConfig()
                            .getServletContext()
                            .getResourceAsStream("reporteJasper/ReporteUsuarios.jasper");
            if (logo != null && reporteUsuario != null) {
                String jsonUsuarios = request.getParameter("repUsuario"); //---
                //Gson gson = new Gson();
                List<usuario> repUsuario = new ArrayList<>();

                repUsuario.add(new usuario());

               JasperReport report = (JasperReport) JRLoader.loadObject(reporteUsuario);//plantilla diseñada
                JRBeanArrayDataSource ds = new JRBeanArrayDataSource(repUsuario.toArray());

                Map<String, Object> parameters = new HashMap();
                parameters.put("ds", ds);
                parameters.put("logo", logo);
                response.setContentType("application/pdf");
                response.addHeader("Content-disposition", "inline; filename=ReportesEmpleados.pdf");
                JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, ds);
                JasperExportManager.exportReportToPdfStream(jasperPrint, out);
                out.flush();
                out.close();
            } else {
                response.setContentType("text/plain");
                out.println("no se pudo generar el reporte");
                out.println("se debe a que la lista de datos no fue recibida o el archivo plantilla del reporte no se ha encontrado");
                out.println("contacte a soporte");
            }
        } catch (Exception e) {
            response.setContentType("text/plain");
            out.print("ocurrió un error al intentar generar el reporte:" + e.getMessage());
            e.printStackTrace();
        }
    } 
}
