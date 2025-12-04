package com.mycompany.viveyatravel.controladores;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
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

        String nombrePaqueteSimple = (String) ses.getAttribute("pdfNombrePaquete");

        if (subtotal == null) subtotal = (total != null ? total : 0.0);
        if (extras   == null) extras   = 0.0;
        if (total    == null) total    = subtotal + extras;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=comprobante.pdf");

        Document doc = new Document(PageSize.A4, 40, 40, 40, 40);

        try {
            PdfWriter.getInstance(doc, response.getOutputStream());
            doc.addTitle("Comprobante de Reserva - ViveYaTravel");
            doc.addAuthor("ViveYaTravel");
            doc.addCreationDate();
            doc.open();

            // ======= COLORES =======
            BaseColor primary   = new BaseColor(52, 152, 219);
            BaseColor darkText  = new BaseColor(44, 62, 80);
            BaseColor softGray  = new BaseColor(245, 247, 250);
            BaseColor softCard  = new BaseColor(250, 252, 253);
            BaseColor accent    = new BaseColor(46, 204, 113);
            BaseColor borderSoft= new BaseColor(220, 224, 228);

            // ======= FUENTES =======
            Font tituloFont    = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, darkText);
            Font subtituloFont = FontFactory.getFont(FontFactory.HELVETICA, 11, new BaseColor(127, 140, 141));
            Font normalFont    = FontFactory.getFont(FontFactory.HELVETICA, 10, darkText);
            Font smallGrayFont = FontFactory.getFont(FontFactory.HELVETICA, 8, new BaseColor(149, 165, 166));
            Font tablaHeaderF  = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            Font tablaBodyF    = FontFactory.getFont(FontFactory.HELVETICA, 9, darkText);
            Font totalFont     = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, darkText);

            // ======= BARRA SUPERIOR =======
            PdfPTable topBar = new PdfPTable(1);
            topBar.setWidthPercentage(100);
            PdfPCell barCell = new PdfPCell(new Phrase(" "));
            barCell.setBackgroundColor(primary);
            barCell.setFixedHeight(4f);
            barCell.setBorder(Rectangle.NO_BORDER);
            topBar.addCell(barCell);
            doc.add(topBar);

            doc.add(new Paragraph(" ")); 

            // ======= CARD HEADER =======
            PdfPTable headerWrapper = new PdfPTable(1);
            headerWrapper.setWidthPercentage(100);

            PdfPCell headerCard = new PdfPCell();
            headerCard.setBackgroundColor(softCard);
            headerCard.setBorder(Rectangle.BOX);
            headerCard.setBorderColor(borderSoft);
            headerCard.setPadding(14f);

            PdfPTable header = new PdfPTable(2);
            header.setWidthPercentage(100);
            header.setWidths(new float[]{3f, 1.6f});

            // -------- Columna izquierda --------
            PdfPCell left = new PdfPCell();
            left.setBorder(Rectangle.NO_BORDER);
            left.setVerticalAlignment(Element.ALIGN_MIDDLE);

            Paragraph empresa = new Paragraph("ViveYaTravel", tituloFont);
            empresa.setSpacingAfter(2f);
            left.addElement(empresa);

            Paragraph compTitle = new Paragraph("Comprobante de Reserva", subtituloFont);
            compTitle.setSpacingAfter(8f);
            left.addElement(compTitle);

            Paragraph fecha = new Paragraph("Fecha de emisión: " + new Date(), smallGrayFont);
            fecha.setSpacingAfter(2f);
            left.addElement(fecha);

            if (asiento != null && !asiento.trim().isEmpty()) {
                Paragraph seat = new Paragraph("Asiento reservado: " + asiento, smallGrayFont);
                seat.setSpacingAfter(2f);
                left.addElement(seat);
            }

            // -------- Columna derecha (LOGO + chip) --------
            PdfPCell right = new PdfPCell();
            right.setBorder(Rectangle.NO_BORDER);
            right.setHorizontalAlignment(Element.ALIGN_RIGHT);

            // CHIP del número de operación
            if (orderId != null && !orderId.trim().isEmpty()) {
                PdfPTable chipTable = new PdfPTable(1);
                chipTable.setWidthPercentage(80);

                PdfPCell chip = new PdfPCell();
                chip.setBackgroundColor(BaseColor.WHITE);
                chip.setBorder(Rectangle.BOX);
                chip.setBorderColor(borderSoft);
                chip.setPadding(6f);

                Paragraph chipLabel = new Paragraph("N° de operación", smallGrayFont);
                chipLabel.setAlignment(Element.ALIGN_CENTER);
                Paragraph chipValue = new Paragraph(orderId, normalFont);
                chipValue.setAlignment(Element.ALIGN_CENTER);
                chipValue.setSpacingBefore(2f);

                chip.addElement(chipLabel);
                chip.addElement(chipValue);
                chipTable.addCell(chip);

                right.addElement(chipTable);
            }

            // ======= LOGO (usando realPath) =======
            try {
                String logoPath = getServletContext().getRealPath("/img/logo.png");
                if (logoPath != null) {
                    Image logo = Image.getInstance(logoPath);
                    logo.scaleToFit(70, 70);
                    logo.setAlignment(Image.ALIGN_RIGHT);

                    Paragraph logoWrapperP = new Paragraph();
                    logoWrapperP.add(logo);
                    logoWrapperP.setSpacingBefore(8f);
                    right.addElement(logoWrapperP);
                } else {
                    System.out.println("❌ No se pudo resolver realPath(/img/logo.png)");
                }
            } catch (Exception e) {
                System.out.println("❌ Error cargando el logo:");
                e.printStackTrace();
            }

            header.addCell(left);
            header.addCell(right);

            headerCard.addElement(header);
            headerWrapper.addCell(headerCard);
            doc.add(headerWrapper);

            doc.add(new Paragraph(" "));

            // ======= DETALLE =======
            Paragraph detalleTitle = new Paragraph("Detalle de la reserva", normalFont);
            detalleTitle.setSpacingAfter(4f);
            doc.add(detalleTitle);

            PdfPTable divider = new PdfPTable(1);
            divider.setWidthPercentage(100);
            PdfPCell dividerCell = new PdfPCell(new Phrase(" "));
            dividerCell.setBorder(Rectangle.BOTTOM);
            dividerCell.setBorderColor(borderSoft);
            dividerCell.setBorderWidthBottom(0.8f);
            dividerCell.setFixedHeight(6f);
            divider.addCell(dividerCell);
            doc.add(divider);

            doc.add(new Paragraph(" "));

            // ======= TABLA =======
            if (compra != null && !compra.isEmpty()) {

                PdfPTable tabla = new PdfPTable(4);
                tabla.setWidthPercentage(100);
                tabla.setSpacingBefore(5f);
                tabla.setWidths(new float[]{4f, 1.5f, 1.5f, 2f});

                tabla.addCell(headerCell("Paquete", primary, tablaHeaderF));
                tabla.addCell(headerCell("Precio (S/.)", primary, tablaHeaderF));
                tabla.addCell(headerCell("Cantidad", primary, tablaHeaderF));
                tabla.addCell(headerCell("Subtotal (S/.)", primary, tablaHeaderF));

                boolean alternate = false;

                for (Paquete p : compra) {
                    BaseColor row = alternate ? softGray : BaseColor.WHITE;
                    alternate = !alternate;

                    PdfPCell c1 = bodyCell(p.getNombrePaquete(), tablaBodyF);
                    c1.setBackgroundColor(row);
                    tabla.addCell(c1);

                    PdfPCell c2 = bodyCell(String.format("%.2f", p.getPrecioPaquete()), tablaBodyF, Element.ALIGN_RIGHT);
                    c2.setBackgroundColor(row);
                    tabla.addCell(c2);

                    PdfPCell c3 = bodyCell(String.valueOf(p.getCantidad()), tablaBodyF, Element.ALIGN_CENTER);
                    c3.setBackgroundColor(row);
                    tabla.addCell(c3);

                    PdfPCell c4 = bodyCell(String.format("%.2f", p.getSubtotal()), tablaBodyF, Element.ALIGN_RIGHT);
                    c4.setBackgroundColor(row);
                    tabla.addCell(c4);
                }

                doc.add(tabla);

            } else {
                if (nombrePaqueteSimple != null && !nombrePaqueteSimple.trim().isEmpty()) {
                    Paragraph paqueteP = new Paragraph("Paquete: " + nombrePaqueteSimple, normalFont);
                    paqueteP.setSpacingAfter(10f);
                    doc.add(paqueteP);
                } else {
                    Paragraph noItems = new Paragraph("No se encontraron ítems para esta compra.", normalFont);
                    noItems.setSpacingAfter(10f);
                    doc.add(noItems);
                }
            }

            // ======= TOTAL =======
            PdfPTable totalesWrapper = new PdfPTable(1);
            totalesWrapper.setWidthPercentage(40);
            totalesWrapper.setHorizontalAlignment(Element.ALIGN_RIGHT);

            PdfPCell totalesCard = new PdfPCell();
            totalesCard.setBackgroundColor(softCard);
            totalesCard.setBorder(Rectangle.BOX);
            totalesCard.setBorderColor(borderSoft);
            totalesCard.setPadding(10f);

            PdfPTable totales = new PdfPTable(2);
            totales.setWidthPercentage(100);
            totales.setWidths(new float[]{2f, 2f});

            totales.addCell(bodyCell("Subtotal", normalFont));
            totales.addCell(bodyCell(String.format("S/. %.2f", subtotal), normalFont, Element.ALIGN_RIGHT));

            totales.addCell(bodyCell("Extras", normalFont));
            totales.addCell(bodyCell(String.format("S/. %.2f", extras), normalFont, Element.ALIGN_RIGHT));

            PdfPCell totalLabelCell = new PdfPCell(new Phrase("TOTAL", totalFont));
            totalLabelCell.setBorder(Rectangle.TOP);
            totalLabelCell.setBorderColor(borderSoft);

            PdfPCell totalValueCell = new PdfPCell(new Phrase(String.format("S/. %.2f", total), totalFont));
            totalValueCell.setBorder(Rectangle.TOP);
            totalValueCell.setBorderColor(borderSoft);
            totalValueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

            totales.addCell(totalLabelCell);
            totales.addCell(totalValueCell);

            totalesCard.addElement(totales);
            totalesWrapper.addCell(totalesCard);
            doc.add(totalesWrapper);

            // ======= NOTA FINAL =======
            Paragraph info = new Paragraph(
                    "Este comprobante certifica la reserva realizada en ViveYaTravel.\n" +
                    "Preséntalo junto con tu documento de identidad.",
                    normalFont
            );
            info.setSpacingBefore(10f);
            doc.add(info);

            Paragraph gracias = new Paragraph("¡Gracias por confiar en ViveYaTravel!", subtituloFont);
            gracias.setAlignment(Element.ALIGN_CENTER);
            doc.add(gracias);

        } catch (DocumentException e) {
            throw new IOException("Error generando el PDF", e);
        } finally {
            doc.close();
        }
    }

    // ======= Helpers =======
    private PdfPCell headerCell(String texto, BaseColor bg, Font font) {
        PdfPCell c = new PdfPCell(new Phrase(texto, font));
        c.setBackgroundColor(bg);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setVerticalAlignment(Element.ALIGN_MIDDLE);
        c.setPadding(7f);
        c.setBorder(Rectangle.NO_BORDER);
        return c;
    }

    private PdfPCell bodyCell(String texto, Font font) {
        return bodyCell(texto, font, Element.ALIGN_LEFT);
    }

    private PdfPCell bodyCell(String texto, Font font, int align) {
        PdfPCell c = new PdfPCell(new Phrase(texto, font));
        c.setHorizontalAlignment(align);
        c.setVerticalAlignment(Element.ALIGN_MIDDLE);
        c.setPadding(5f);
        return c;
    }
}
