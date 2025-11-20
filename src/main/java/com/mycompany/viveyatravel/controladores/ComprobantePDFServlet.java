package com.mycompany.viveyatravel.controladores;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// iText 5 imports (CORRECTOS)
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import com.mycompany.viveyatravel.modelo.dto.Paquete;

@WebServlet("/ComprobantePDF")
public class ComprobantePDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession();

        List<Paquete> compra = (List<Paquete>) ses.getAttribute("compraReciente");
        Double total = (Double) ses.getAttribute("totalPagado");
        String orderId = (String) ses.getAttribute("orderId");

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=comprobante.pdf");

        Document doc = new Document();

        try {
            PdfWriter.getInstance(doc, response.getOutputStream());
            doc.open();

            Font tituloFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);

            // TÍTULO
            Paragraph titulo = new Paragraph("Comprobante de Pago\n\n", tituloFont);
            titulo.setAlignment(Element.ALIGN_CENTER);
            doc.add(titulo);

            doc.add(new Paragraph("Número de Orden: " + orderId, normalFont));
            doc.add(new Paragraph("Total Pagado: S/. " + String.format("%.2f", total) + "\n\n", normalFont));

            // TABLA
            PdfPTable tabla = new PdfPTable(3);
            tabla.setWidthPercentage(100);

            tabla.addCell("Paquete");
            tabla.addCell("Cantidad");
            tabla.addCell("Subtotal");

            if (compra != null) {
                for (Paquete p : compra) {
                    tabla.addCell(p.getNombrePaquete());
                    tabla.addCell(String.valueOf(p.getCantidad()));
                    tabla.addCell("S/. " + String.format("%.2f", p.getSubtotal()));
                }
            }

            doc.add(tabla);

            doc.add(new Paragraph("\nGracias por su compra.", normalFont));

        } catch (DocumentException e) {
            throw new IOException(e);
        }

        doc.close();
    }
}
