package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.cargo;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.servicios.ConectarBD;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class usuarioDAO {

    private Connection cn;

    public usuarioDAO() {
        cn = new ConectarBD().getConexion();   //Inicia la conexion a la BD
    }

    public usuario identificar(usuario user) throws SQLException {
        usuario usu = null;     //Va a recibir el objeto usuario
        PreparedStatement ps = null;   //Para preparar la consulta
        ResultSet rs = null;
        //La consulta desde la base de datos
        String cadSQL = "SELECT u.idUsuario, u.nombre, u.apellido, u.nroCelular, u.nroDni, c.nombreCargo FROM usuario u\n"
                + "inner join cargo c on u.idCargo = c.idCargo\n"
                + "where u.correoElectronico = '" + user.getCorreoElectronico() + "' "
                + "AND u.clave = '" + user.getClave() + "'";
        try {
            ps = cn.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            if (rs.next() == true) {  //Si encuentra una consulta, realiza el bloque de codigo
                usu = new usuario();
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setNombre(rs.getString("nombre"));
                usu.setApellido(rs.getString("apellido"));
                usu.setNroCelular(rs.getInt("nroCelular"));
                usu.setNroDni(rs.getInt("nroDni"));
                usu.setCorreoElectronico(user.getCorreoElectronico());
                usu.setClave(user.getClave());
                usu.setCargo(new cargo());
                usu.getCargo().setNombreCargo(rs.getString("nombreCargo"));

            }
        } catch (Exception e) {  //Manejo de execpciones
            System.out.println("Error " + e.getMessage());
        } finally { //Cierre del Resulset y preparedStatement
            if (rs != null && rs.isClosed() == false) {
                rs.close();
            }
            rs = null;
            if (ps != null && ps.isClosed() == false) {
                ps.close();
            }
            ps = null;

        }
        return usu;
    }

    public usuario registrar(usuario user) throws SQLException {
        usuario usu = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String cadSQL = "INSERT INTO usuario (nombre, apellido, nroCelular, nroDni, correoElectronico, clave, idCargo) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try {
            ps = cn.prepareStatement(cadSQL);
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setInt(3, user.getNroCelular());
            ps.setInt(4, user.getNroDni());
            ps.setString(5, user.getCorreoElectronico());
            ps.setString(6, user.getClave());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al registrar el usuario: " + e.getMessage());
        }

        return usu;
    }

    public void actualizar(usuario user) throws SQLException {
        String sql = "UPDATE usuario SET nombre = ?, apellido = ?, nroCelular = ?, nroDni = ?, correoElectronico = ?, clave = ? WHERE idUsuario = ?";
        PreparedStatement ps = null;
        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setInt(3, user.getNroCelular());
            ps.setInt(4, user.getNroDni());
            ps.setString(5, user.getCorreoElectronico());
            ps.setString(6, user.getClave());
            ps.setInt(7, user.getIdUsuario());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al actualizar: " + e.getMessage());
        } finally {
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
    }

    public boolean existeUsuarioPorDni(int nroDni) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String cadSQL = "SELECT COUNT(*) FROM usuario WHERE nroDni = ?"; //Verifica si existe un dni que ya esta siendo usado
        boolean existe = false;
        try {
            ps = cn.prepareStatement(cadSQL);
            ps.setInt(1, nroDni);
            rs = ps.executeQuery();
            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar la existencia del usuario: " + e.getMessage());
        } finally {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return existe;
    }

    public boolean existeUsuarioPorCorreo(String correoElectronico) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        String cadSQL = "SELECT COUNT(*) FROM usuario WHERE correoElectronico = ?"; //Verifica si existe un dni que ya esta siendo usado
        boolean existeCorreo = false;
        try {
            ps = cn.prepareStatement(cadSQL);
            ps.setString(1, correoElectronico);
            rs = ps.executeQuery();
            if (rs.next()) {
                existeCorreo = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar la existencia del usuario: " + e.getMessage());
        } finally {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return existeCorreo;
    }

//----------------------
    public List<usuario> repUsuario() {
        List<usuario> repUsuario = new ArrayList<>();
        String reporte = "SELECT idUsuario, nombre, apellido, nroCelular, nroDni, correoElectronico FROM usuario WHERE idCargo = 1";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = cn.prepareStatement(reporte);
            rs = ps.executeQuery();
            while (rs.next()) {
                usuario u = new usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setNroCelular(rs.getInt("nroCelular"));
                u.setNroDni(rs.getInt("nroDni"));
                u.setCorreoElectronico(rs.getString("correoElectronico"));
                repUsuario.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener usuarios: " + e.getMessage());
        } finally {
            try {
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
                if (ps != null && !ps.isClosed()) {
                    ps.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return repUsuario;
    }

    public ByteArrayInputStream exportarExcel() throws IOException {
        // Obtener lista de usuarios 
        List<usuario> repUsuario = repUsuario();

        // Crear el libro y hoja de Excel
        Workbook libro = new HSSFWorkbook();
        ByteArrayOutputStream flujo = new ByteArrayOutputStream();
        Sheet hoja = libro.createSheet("Usuarios");

        // Datos de la empresa
        String nom = "Vive Ya Travel";
        String ruc = "987654321324";
        String cel = "987654321";
        String logoURL = "https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png";

        // Descargar el logo desde la URL y ajustar el tamaño
        URL url = new URL(logoURL);
        InputStream is = url.openStream();
        byte[] bytes = IOUtils.toByteArray(is);
        is.close();

        int logoHeight = 150; // Altura de la imagen
        int logoWidth = 250; // Ancho de la imagen

        int pictureIdx = libro.addPicture(bytes, Workbook.PICTURE_TYPE_PNG);
        CreationHelper helper = libro.getCreationHelper();
        Drawing drawing = hoja.createDrawingPatriarch();
        ClientAnchor anchor = helper.createClientAnchor();
        anchor.setCol1(0);
        anchor.setRow1(0);
        anchor.setCol2(1);
        anchor.setRow2(4);

        // Crear la imagen y ajustar tamaño
        Picture pict = drawing.createPicture(anchor, pictureIdx);
        pict.resize(1.0, 1.0); // Redimensionar al tamaño original de la imagen
        pict.resize(logoWidth / pict.getImageDimension().getWidth(), logoHeight / pict.getImageDimension().getHeight());

        // Establecer el encabezado 
        Row headerRow = hoja.createRow(0);
        Cell cellEmpresa = headerRow.createCell(2);
        cellEmpresa.setCellValue(nom);
        CellStyle styleEmpresa = libro.createCellStyle();
        Font fontEmpresa = libro.createFont();
        fontEmpresa.setFontHeightInPoints((short) 18);
        fontEmpresa.setBold(true);
        styleEmpresa.setFont(fontEmpresa);
        cellEmpresa.setCellStyle(styleEmpresa);

        Row rucRow = hoja.createRow(1);
        Cell cellRucLabel = rucRow.createCell(2);
        cellRucLabel.setCellValue("R.U.C:");
        CellStyle styleLabel = libro.createCellStyle();
        Font fontLabel = libro.createFont();
        fontLabel.setBold(true);
        styleLabel.setFont(fontLabel);
        cellRucLabel.setCellStyle(styleLabel);

        Cell cellRucValue = rucRow.createCell(3);
        cellRucValue.setCellValue(ruc);

        Row telRow = hoja.createRow(2);
        Cell cellTelLabel = telRow.createCell(2);
        cellTelLabel.setCellValue("Teléfono:");
        cellTelLabel.setCellStyle(styleLabel);

        Cell cellTelValue = telRow.createCell(3);
        cellTelValue.setCellValue(cel);

        // Crear la fila de cabecera y poner los títulos
        Row cabecera = hoja.createRow(4);
        String[] titulos = {"ID", "NOMBRE", "APELLIDO", "TELÉFONO", "DNI", "CORREO"};

        // Crear estilo para la cabecera
        CellStyle estiloCabecera = libro.createCellStyle();
        estiloCabecera.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
        estiloCabecera.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        estiloCabecera.setBorderTop(BorderStyle.THIN);
        estiloCabecera.setBorderBottom(BorderStyle.THIN);
        estiloCabecera.setBorderLeft(BorderStyle.THIN);
        estiloCabecera.setBorderRight(BorderStyle.THIN);
        Font font = libro.createFont();
        font.setBold(true);
        estiloCabecera.setFont(font);

        // Llenar la cabecera con los títulos
        for (int i = 0; i < titulos.length; i++) {
            Cell cell = cabecera.createCell(i);
            cell.setCellValue(titulos[i]);
            // Aplicar el estilo
            cell.setCellStyle(estiloCabecera);
        }

        // Estilo para las celdas de datos
        CellStyle estiloCelda = libro.createCellStyle();
        estiloCelda.setFillForegroundColor(IndexedColors.WHITE1.getIndex());
        estiloCelda.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        estiloCelda.setBorderTop(BorderStyle.THIN);
        estiloCelda.setBorderBottom(BorderStyle.THIN);
        estiloCelda.setBorderLeft(BorderStyle.THIN);
        estiloCelda.setBorderRight(BorderStyle.THIN);

        // Llenar la hoja con los datos de los usuarios
        for (int i = 0; i < repUsuario.size(); i++) {
            usuario us = repUsuario.get(i);
            Row fd = hoja.createRow(i + 5); // Empezar desde la fila siguiente a la cabecera
            fd.createCell(0).setCellValue(us.getIdUsuario());
            fd.createCell(1).setCellValue(us.getNombre());
            fd.createCell(2).setCellValue(us.getApellido());
            fd.createCell(3).setCellValue(us.getNroCelular());
            fd.createCell(4).setCellValue(us.getNroDni());
            fd.createCell(5).setCellValue(us.getCorreoElectronico());

            // Aplicar estilo a cada celda de la fila de datos
            for (int j = 0; j < titulos.length; j++) {
                fd.getCell(j).setCellStyle(estiloCelda);
            }
        }

        // Ajustar tamaño de columnas
        for (int i = 0; i < titulos.length; i++) {
            hoja.autoSizeColumn(i);
        }

        // Escribir el libro en el flujo de salida
        libro.write(flujo);
        libro.close();

        return new ByteArrayInputStream(flujo.toByteArray());
    }

    public JasperPrint exportarPDF(ServletContext context) throws JRException {
        // Obtener lista de usuarios 
        List<usuario> repUsuario = repUsuario();
        // Ruta del archivo JRXML
        String jrxmlFilePath = context.getRealPath("/reporteJasper/usuarios1.jrxml");

        if (jrxmlFilePath == null) {
            throw new JRException("No se pudo obtener la ruta real del archivo JRXML");
        }

        // Compilar el archivo JRXML a Jasper
        //JasperReport jasperReportFuente = JasperCompileManager.compileReport(jrxmlFilePath);
        // Compilar el archivo JRXML a Jasper
        JasperReport jasperReportFuente;
        try {
            jasperReportFuente = JasperCompileManager.compileReport(jrxmlFilePath);
        } catch (JRException e) {
            throw new JRException("Error al compilar el archivo JRXML", e);
        }

        // Crear un datasource para llenar el reporte
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(repUsuario);

        // Llenar el reporte con los datos
        //JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReportFuente,
        //       new HashMap<>(),
        //       cn);
        JasperPrint jasperPrint;
        try {
            jasperPrint = JasperFillManager.fillReport(jasperReportFuente,
                    new HashMap<>(),
                    dataSource);
        } catch (JRException e) {
            throw new JRException("Error al llenar el reporte", e);
        }

        return jasperPrint;
    }

}
