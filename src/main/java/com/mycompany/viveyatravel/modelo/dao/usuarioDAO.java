package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.cargo;
import com.mycompany.viveyatravel.modelo.dto.usuario;
import com.mycompany.viveyatravel.servicios.ConectarBD;
import com.mycompany.viveyatravel.util.HashUtil;
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
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;

public class usuarioDAO {

    private Connection cn;

    public usuarioDAO() {
        cn = new ConectarBD().getConexion();
    }

    // --- LOGIN ---
    public usuario identificar(usuario user) throws SQLException {
        usuario usu = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String claveHash = HashUtil.hashPassword(user.getClave());

        String sql = "SELECT u.idUsuario, u.nombre, u.apellido, u.nroCelular, u.nroDni, "
                + "u.genero, c.nombreCargo "
                + "FROM usuario u "
                + "INNER JOIN cargo c ON u.idCargo = c.idCargo "
                + "WHERE u.correoElectronico = ? AND u.clave = ?";

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, user.getCorreoElectronico());
            ps.setString(2, claveHash);
            rs = ps.executeQuery();

            if (rs.next()) {
                usu = new usuario();
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setNombre(rs.getString("nombre"));
                usu.setApellido(rs.getString("apellido"));
                usu.setNroCelular(rs.getInt("nroCelular"));
                usu.setNroDni(rs.getInt("nroDni"));
                usu.setCorreoElectronico(user.getCorreoElectronico());
                usu.setGenero(rs.getString("genero"));
                usu.setCargo(new cargo());
                usu.getCargo().setNombreCargo(rs.getString("nombreCargo"));
            }
        } catch (Exception e) {
            System.out.println("Error al identificar usuario: " + e.getMessage());
        } finally {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return usu;
    }
    // --- OBTENER FOTO POR ID (FALTABA ESTE MÉTODO) ---

    public byte[] obtenerFotoPorId(int idUsuario) throws SQLException {
        byte[] foto = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT fotoPerfil FROM usuario WHERE idUsuario = ?";

        try {
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                foto = rs.getBytes("fotoPerfil");
            }
        } catch (Exception e) {
            System.out.println("Error al obtener foto: " + e.getMessage());
        } finally {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return foto;
    }

    // --- REGISTRO ---
    public usuario registrar(usuario user) throws SQLException {
        usuario usu = null;
        PreparedStatement ps = null;

        String sql = "INSERT INTO usuario (nombre, apellido, nroCelular, nroDni, correoElectronico, clave, genero, idCargo) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setInt(3, user.getNroCelular());
            ps.setInt(4, user.getNroDni());
            ps.setString(5, user.getCorreoElectronico());
            ps.setString(6, HashUtil.hashPassword(user.getClave())); // clave cifrada
            ps.setString(7, user.getGenero()); // Guardar género
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al registrar usuario: " + e.getMessage());
        } finally {
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return usu;
    }

    // --- ACTUALIZAR PERFIL (CORREGIDO: INCLUYE FOTO) ---
    public void actualizar(usuario user) throws SQLException {
        // Agregamos ", fotoPerfil = ?" a la consulta SQL
        String sql = "UPDATE usuario SET nombre = ?, apellido = ?, nroCelular = ?, fotoPerfil = ? WHERE idUsuario = ?";
        PreparedStatement ps = null;

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setInt(3, user.getNroCelular());

            // === Lógica para la Foto ===
            if (user.getFotoPerfil() != null && user.getFotoPerfil().length > 0) {
                // Si hay foto nueva, la guardamos
                ps.setBinaryStream(4, new ByteArrayInputStream(user.getFotoPerfil()));
            } else {
                // Si no hay foto nueva, necesitamos mantener la anterior.
                // PERO, como tu SQL actualiza todo, si pasamos NULL borraría la foto vieja.
                // TRUCO: En el Servlet ya nos aseguramos de pasar la foto vieja si no hay nueva.
                // Si aun así llega null, es porque el usuario quiere borrarla o es un error.
                // Para estar seguros, usamos setObject con tipo BLOB.
                ps.setObject(4, user.getFotoPerfil(), java.sql.Types.BLOB);
            }

            ps.setInt(5, user.getIdUsuario());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new SQLException("Error al actualizar datos: " + e.getMessage());
        } finally {
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
    }

    public boolean eliminar(usuario u) {
        boolean resp = false;
        PreparedStatement ps = null;

        try {
            String sql = "DELETE FROM usuario WHERE idUsuario = ?";
            ps = cn.prepareStatement(sql);
            ps.setInt(1, u.getIdUsuario());

            int filas = ps.executeUpdate();
            if (filas > 0) {
                resp = true; // si eliminó al menos 1 fila
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return resp;
    }

    //Obtener nombre de usuario segun correo
    public usuario obtenerPorCorreo(String correo) throws SQLException {
        String sql = "SELECT * FROM usuario WHERE correoElectronico = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        usuario u = null;

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, correo);
            rs = ps.executeQuery();

            if (rs.next()) {
                u = new usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreoElectronico(rs.getString("correoElectronico"));
                u.setClave(rs.getString("clave"));
                // otros campos si quieres

            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        }
        return u;
    }

    public void actualizarClave(usuario u) throws SQLException {
        String sql = "UPDATE usuario SET clave = ? WHERE correoElectronico = ?";
        PreparedStatement ps = null;
        try {
            ps = cn.prepareStatement(sql);

            // Encriptar la contraseña antes de guardarla
            //String claveHash = com.mycompany.viveyatravel.util.HashUtil.hashPassword(u.getClave());
            ps.setString(1, HashUtil.hashPassword(u.getClave()));
            //ps.setString(1, u.getClave());
            ps.setString(2, u.getCorreoElectronico());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error al actualizar clave: " + e.getMessage());
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
        String cadSQL = "SELECT COUNT(*) FROM usuario WHERE correoElectronico = ?"; //Verifica si existe un correo que ya esta siendo usado
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
        List<usuario> repUsuario = repUsuario();

        // 1. Crear libro y hoja
        Workbook libro = new HSSFWorkbook();
        Sheet hoja = libro.createSheet("Reporte de Usuarios");
        ByteArrayOutputStream flujo = new ByteArrayOutputStream();

        // --- DEFINICIÓN DE ESTILOS (CLAVE PARA EL LOOK CORPORATIVO) ---
        // Estilo Título Principal (Empresa)
        CellStyle styleTitulo = libro.createCellStyle();
        Font fontTitulo = libro.createFont();
        fontTitulo.setBold(true);
        fontTitulo.setFontHeightInPoints((short) 20);
        fontTitulo.setColor(IndexedColors.DARK_BLUE.getIndex());
        fontTitulo.setFontName("Arial");
        styleTitulo.setFont(fontTitulo);
        styleTitulo.setAlignment(HorizontalAlignment.CENTER);

        // Estilo Etiquetas (RUC, Teléfono)
        CellStyle styleLabel = libro.createCellStyle();
        Font fontLabel = libro.createFont();
        fontLabel.setBold(true);
        fontLabel.setColor(IndexedColors.GREY_80_PERCENT.getIndex());
        styleLabel.setFont(fontLabel);
        styleLabel.setAlignment(HorizontalAlignment.RIGHT);

        // Estilo Cabecera de Tabla (Fondo oscuro, texto blanco)
        CellStyle styleCabecera = libro.createCellStyle();
        styleCabecera.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        styleCabecera.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        Font fontCabecera = libro.createFont();
        fontCabecera.setBold(true);
        fontCabecera.setColor(IndexedColors.WHITE.getIndex());
        fontCabecera.setFontHeightInPoints((short) 12);
        styleCabecera.setFont(fontCabecera);
        styleCabecera.setAlignment(HorizontalAlignment.CENTER);
        styleCabecera.setVerticalAlignment(VerticalAlignment.CENTER);
        styleCabecera.setBorderBottom(BorderStyle.THIN);
        styleCabecera.setBorderTop(BorderStyle.THIN);
        styleCabecera.setBorderLeft(BorderStyle.THIN);
        styleCabecera.setBorderRight(BorderStyle.THIN);

        // Estilo Datos (Bordes finos)
        CellStyle styleDatos = libro.createCellStyle();
        styleDatos.setBorderBottom(BorderStyle.THIN);
        styleDatos.setBorderTop(BorderStyle.THIN);
        styleDatos.setBorderLeft(BorderStyle.THIN);
        styleDatos.setBorderRight(BorderStyle.THIN);
        styleDatos.setAlignment(HorizontalAlignment.LEFT);

        // Estilo Datos Centrados (Para IDs, DNI, Telf)
        CellStyle styleDatosCenter = libro.createCellStyle();
        styleDatosCenter.cloneStyleFrom(styleDatos);
        styleDatosCenter.setAlignment(HorizontalAlignment.CENTER);

        // --- LOGO E INFORMACIÓN ---
        try {
            String logoURL = "https://www.viveyatravel.com/imagenes/logo-web-vive-ya-travel-2.png";
            URL url = new URL(logoURL);
            InputStream is = url.openStream();
            byte[] bytes = IOUtils.toByteArray(is);
            is.close();

            int pictureIdx = libro.addPicture(bytes, Workbook.PICTURE_TYPE_PNG);
            CreationHelper helper = libro.getCreationHelper();
            Drawing drawing = hoja.createDrawingPatriarch();
            ClientAnchor anchor = helper.createClientAnchor();

            // Posicionar logo (Columnas 0-1, Filas 0-3)
            anchor.setCol1(0);
            anchor.setRow1(0);
            anchor.setCol2(2); // Ocupa hasta la columna 2
            anchor.setRow2(4); // Ocupa hasta la fila 4

            Picture pict = drawing.createPicture(anchor, pictureIdx);
            // Ajuste manual para que no se deforme demasiado, depende de tu logo
            pict.resize(0.8);
        } catch (Exception e) {
            System.out.println("No se pudo cargar el logo: " + e.getMessage());
        }

        // Datos Empresa (Centrados y combinados)
        Row rowTitulo = hoja.createRow(1);
        Cell cellTitulo = rowTitulo.createCell(2);
        cellTitulo.setCellValue("VIVE YA TRAVEL S.A.C.");
        cellTitulo.setCellStyle(styleTitulo);

        // Combinar celdas para el título (Fila 1, Col 2 a 5)
        hoja.addMergedRegion(new CellRangeAddress(1, 1, 2, 5));

        // Datos Adicionales
        Row rowRuc = hoja.createRow(2);
        Cell cellRucL = rowRuc.createCell(2);
        cellRucL.setCellValue("R.U.C:");
        cellRucL.setCellStyle(styleLabel);
        Cell cellRucV = rowRuc.createCell(3);
        cellRucV.setCellValue("20601234567"); // Puse un RUC ficticio válido de ejemplo

        Row rowTel = hoja.createRow(3);
        Cell cellTelL = rowTel.createCell(2);
        cellTelL.setCellValue("Teléfono:");
        cellTelL.setCellStyle(styleLabel);
        Cell cellTelV = rowTel.createCell(3);
        cellTelV.setCellValue("987 654 321");

        // --- TABLA DE DATOS ---
        int filaInicio = 5;
        Row headerRow = hoja.createRow(filaInicio);
        headerRow.setHeightInPoints(25); // Altura de cabecera más alta

        String[] titulos = {"ID", "NOMBRE", "APELLIDO", "TELÉFONO", "DNI", "CORREO"};

        for (int i = 0; i < titulos.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(titulos[i]);
            cell.setCellStyle(styleCabecera);
        }

        // Agregar AutoFiltro (Muy útil para usuarios)
        hoja.setAutoFilter(new CellRangeAddress(filaInicio, filaInicio, 0, titulos.length - 1));

        // Llenar datos
        int rowNum = filaInicio + 1;
        for (usuario us : repUsuario) {
            Row row = hoja.createRow(rowNum++);

            // ID (Centrado)
            Cell c0 = row.createCell(0);
            c0.setCellValue(us.getIdUsuario());
            c0.setCellStyle(styleDatosCenter);

            // Nombre (Izquierda)
            Cell c1 = row.createCell(1);
            c1.setCellValue(us.getNombre());
            c1.setCellStyle(styleDatos);

            // Apellido (Izquierda)
            Cell c2 = row.createCell(2);
            c2.setCellValue(us.getApellido());
            c2.setCellStyle(styleDatos);

            // Teléfono (Centrado)
            Cell c3 = row.createCell(3);
            c3.setCellValue(us.getNroCelular());
            c3.setCellStyle(styleDatosCenter);

            // DNI (Centrado)
            Cell c4 = row.createCell(4);
            c4.setCellValue(us.getNroDni());
            c4.setCellStyle(styleDatosCenter);

            // Correo (Izquierda)
            Cell c5 = row.createCell(5);
            c5.setCellValue(us.getCorreoElectronico());
            c5.setCellStyle(styleDatos);
        }

        // Ajustar columnas automáticamente
        for (int i = 0; i < titulos.length; i++) {
            hoja.autoSizeColumn(i);
            // Dar un poco de aire extra al ancho automático
            int currentWidth = hoja.getColumnWidth(i);
            hoja.setColumnWidth(i, (int) (currentWidth * 1.2));
        }

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
