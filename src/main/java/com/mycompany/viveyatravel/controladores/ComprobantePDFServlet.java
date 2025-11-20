package com.mycompany.viveyatravel.controladores;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.mycompany.viveyatravel.modelo.dto.Paquete;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ComprobantePDF")
public class ComprobantePDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession();

        @SuppressWarnings("unchecked")
        List<Paquete> compra = (List<Paquete>) ses.getAttribute("compraReciente");
        Double total    = (Double) ses.getAttribute("totalPagado");
        String orderId  = (String) ses.getAttribute("orderId");

        Double subtotal = (Double) ses.getAttribute("pdfSubtotal");
        Double extras   = (Double) ses.getAttribute("pdfExtras");
        String asiento  = (String) ses.getAttribute("pdfNumeroAsiento");

        if (subtotal == null) subtotal = (total != null ? total : 0.0);
        if (extras   == null) extras   = 0.0;
        if (total    == null) total    = subtotal + extras;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=comprobante.pdf");

        Document doc = new Document();

        try {
            PdfWriter.getInstance(doc, response.getOutputStream());
            doc.open();

            // ======= FUENTES =======
            Font tituloFont   = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
            Font subtituloFont= FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.GRAY);
            Font normalFont   = FontFactory.getFont(FontFactory.HELVETICA, 11, BaseColor.DARK_GRAY);
            Font tablaHeaderF = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE);
            Font tablaBodyF   = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.DARK_GRAY);
            Font totalFont    = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.BLACK);

            // ======= ENCABEZADO CON LOGO =======
            PdfPTable header = new PdfPTable(2);
            header.setWidthPercentage(100);
            header.setWidths(new float[]{3f, 1.3f});

            // Texto empresa
            PdfPCell left = new PdfPCell();
            left.setBorder(Rectangle.NO_BORDER);
            left.addElement(new Paragraph("ViveYaTravel", tituloFont));
            left.addElement(new Paragraph("Comprobante de Reserva", subtituloFont));
            left.addElement(new Paragraph("Fecha: " + new Date(), normalFont));
            if (orderId != null) {
                left.addElement(new Paragraph("N° de operación: " + orderId, normalFont));
            }
            if (asiento != null && !asiento.trim().isEmpty()) {
                left.addElement(new Paragraph("Asiento reservado: " + asiento, normalFont));
            }

            // Logo (opcional)
            PdfPCell right = new PdfPCell();
            right.setBorder(Rectangle.NO_BORDER);
            right.setHorizontalAlignment(Element.ALIGN_RIGHT);

            try {
                // PON AQUÍ TU LOGO: /web/img/logo.png
                String logoPath = getServletContext().getRealPath("/img/logo.png");
                Image logo = Image.getInstance(logoPath);
                logo.scaleToFit(80, 80);
                logo.setAlignment(Image.ALIGN_RIGHT);
                right.addElement(logo);
            } catch (Exception e) {
                // Si no hay logo, no pasa nada
            }

            header.addCell(left);
            header.addCell(right);
            doc.add(header);

            doc.add(new Paragraph(" ")); // espacio

            // ======= TABLA DE ITEMS =======
            if (compra != null && !compra.isEmpty()) {
                PdfPTable tabla = new PdfPTable(4);
                tabla.setWidthPercentage(100);
                tabla.setSpacingBefore(5f);
                tabla.setWidths(new float[]{4f, 1.5f, 1.5f, 2f});

                BaseColor headerBg = new BaseColor(52, 152, 219); // azul bonito

                // Encabezados
                tabla.addCell(headerCell("Paquete", headerBg, tablaHeaderF));
                tabla.addCell(headerCell("Precio (S/.)", headerBg, tablaHeaderF));
                tabla.addCell(headerCell("Cantidad", headerBg, tablaHeaderF));
                tabla.addCell(headerCell("Subtotal (S/.)", headerBg, tablaHeaderF));

                for (Paquete p : compra) {
                    if (p == null) continue;

                    tabla.addCell(bodyCell(p.getNombrePaquete(), tablaBodyF));
                    tabla.addCell(bodyCell(String.format("%.2f", p.getPrecioPaquete()), tablaBodyF));
                    tabla.addCell(bodyCell(String.valueOf(p.getCantidad()), tablaBodyF));
                    tabla.addCell(bodyCell(String.format("%.2f", p.getSubtotal()), tablaBodyF));
                }

                doc.add(tabla);
            } else {
                doc.add(new Paragraph("No se encontraron ítems para esta compra.\n", normalFont));
            }

            doc.add(new Paragraph(" "));

            // ======= RESUMEN DE TOTALES =======
            PdfPTable totales = new PdfPTable(2);
            totales.setWidthPercentage(40);
            totales.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totales.setWidths(new float[]{2f, 2f});

            totales.addCell(bodyCell("Subtotal", normalFont));
            totales.addCell(bodyCell(String.format("S/. %.2f", subtotal), normalFont, Element.ALIGN_RIGHT));

            totales.addCell(bodyCell("Extras", normalFont));
            totales.addCell(bodyCell(String.format("S/. %.2f", extras), normalFont, Element.ALIGN_RIGHT));

            PdfPCell totalLabel = new PdfPCell(new Phrase("TOTAL", totalFont));
            totalLabel.setHorizontalAlignment(Element.ALIGN_LEFT);
            totalLabel.setBorder(Rectangle.TOP);
            totalLabel.setPaddingTop(5f);

            PdfPCell totalValue = new PdfPCell(new Phrase(String.format("S/. %.2f", total), totalFont));
            totalValue.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalValue.setBorder(Rectangle.TOP);
            totalValue.setPaddingTop(5f);

            totales.addCell(totalLabel);
            totales.addCell(totalValue);

            doc.add(totales);

            doc.add(new Paragraph(" "));

            // ======= TEXTO FINAL =======
            Paragraph info = new Paragraph(
                    "Este comprobante certifica la reserva realizada a través de la plataforma ViveYaTravel.\n" +
                    "Por favor, preséntalo junto con tu documento de identidad el día del viaje.\n\n",
                    normalFont
            );
            info.setAlignment(Element.ALIGN_LEFT);
            doc.add(info);

            Paragraph gracias = new Paragraph("¡Gracias por confiar en ViveYaTravel! ✈🚌", subtituloFont);
            gracias.setAlignment(Element.ALIGN_CENTER);
            doc.add(gracias);

        } catch (DocumentException e) {
            throw new IOException("Error generando el PDF", e);
        } finally {
            doc.close();
        }
    }

    // ======= Helpers para celdas =======
    private PdfPCell headerCell(String texto, BaseColor bg, Font font) {
        PdfPCell c = new PdfPCell(new Phrase(texto, font));
        c.setBackgroundColor(bg);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setPadding(5f);
        return c;
    }

    private PdfPCell bodyCell(String texto, Font font) {
        return bodyCell(texto, font, Element.ALIGN_LEFT);
    }

    private PdfPCell bodyCell(String texto, Font font, int align) {
        PdfPCell c = new PdfPCell(new Phrase(texto, font));
        c.setHorizontalAlignment(align);
        c.setPadding(4f);
        return c;
    }
}
