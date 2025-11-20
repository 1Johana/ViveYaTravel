package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.Paquete;
import com.mycompany.viveyatravel.servicios.ConectarBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaqueteDAO {

    Connection cnx;
    ConectarBD cn = new ConectarBD();
    PreparedStatement ps;
    ResultSet rs;

    public PaqueteDAO() {
        cnx = new ConectarBD().getConexion();
    }

    public Paquete get(int idp) {
        Paquete p = null;
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE idPaquete=? ";

        try {
            ps = cnx.prepareStatement(cadSQL);
            ps.setInt(1, idp);
            rs = ps.executeQuery();
            if (rs.next()) {
                p = new Paquete();
                p.setIdPaquete(rs.getInt("idPaquete"));
                p.setNombrePaquete(rs.getString("nombrePaquete"));
                p.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                p.setPrecioPaquete(rs.getDouble("precioPaquete"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoria(rs.getString("categoria"));
                p.setDetallePaquete(rs.getString("detallePaquete"));
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println("Error al obtener paquete por ID: " + e.getMessage());
        }
        return p;
    }

    /**
     * Lista los paquetes de TOURS (categoria='T') con filtros.
     */
    public List listar(String nombre, String precio, String orden) {
        List<Paquete> lista = new ArrayList<>();
        List<Object> params = new ArrayList<>(); // Lista para los parámetros del PreparedStatement

        //Consulta SQL base
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE categoria='T'";

        // --- Construcción dinámica de la consulta ---
        // 1. Filtro por Nombre
        if (nombre != null && !nombre.isEmpty()) {
            cadSQL += " AND nombrePaquete LIKE ?";
            params.add("%" + nombre + "%");
        }

        // 2. Filtro por Precio
        if (precio != null && !precio.isEmpty()) {
            switch (precio) {
                case "100":
                    cadSQL += " AND precioPaquete < 100";
                    break;
                case "200":
                    cadSQL += " AND precioPaquete >= 100 AND precioPaquete <= 200";
                    break;
                case "201":
                    cadSQL += " AND precioPaquete > 200";
                    break;
            }
        }

        // 3. Ordenamiento
        if (orden != null && !orden.isEmpty()) {
            switch (orden) {
                case "precio_asc":
                    cadSQL += " ORDER BY precioPaquete ASC";
                    break;
                case "precio_desc":
                    cadSQL += " ORDER BY precioPaquete DESC";
                    break;
                case "nombre_asc":
                    cadSQL += " ORDER BY nombrePaquete ASC";
                    break;
            }
        }

        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);

            // Asignar los parámetros dinámicos
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Paquete tur = new Paquete();
                tur.setIdPaquete(rs.getInt("idPaquete"));
                tur.setNombrePaquete(rs.getString("nombrePaquete"));
                tur.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                tur.setPrecioPaquete(rs.getDouble("precioPaquete"));
                tur.setImagen(rs.getString("imagen"));
                tur.setCategoria(rs.getString("categoria"));
                tur.setDetallePaquete(rs.getString("detallePaquete"));
                lista.add(tur);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar paquetes (Tours) con filtros: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Lista los paquetes de PROMOCIONES (categoria='P') con filtros.
     */
    public List list(String nombre, String precio, String orden) {
        List<Paquete> promociones = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        //Consulta SQL base
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE categoria='P'";

        // 1. Filtro por Nombre
        if (nombre != null && !nombre.isEmpty()) {
            cadSQL += " AND nombrePaquete LIKE ?";
            params.add("%" + nombre + "%");
        }

        // 2. Filtro por Precio
        if (precio != null && !precio.isEmpty()) {
            switch (precio) {
                case "100":
                    cadSQL += " AND precioPaquete < 100";
                    break;
                case "200":
                    cadSQL += " AND precioPaquete >= 100 AND precioPaquete <= 200";
                    break;
                case "201":
                    cadSQL += " AND precioPaquete > 200";
                    break;
            }
        }

        // 3. Ordenamiento
        if (orden != null && !orden.isEmpty()) {
            switch (orden) {
                case "precio_asc":
                    cadSQL += " ORDER BY precioPaquete ASC";
                    break;
                case "precio_desc":
                    cadSQL += " ORDER BY precioPaquete DESC";
                    break;
                case "nombre_asc":
                    cadSQL += " ORDER BY nombrePaquete ASC";
                    break;
            }
        }

        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);

            // Asignar los parámetros dinámicos
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Paquete prom = new Paquete();
                prom.setIdPaquete(rs.getInt("idPaquete"));
                prom.setNombrePaquete(rs.getString("nombrePaquete"));
                prom.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                prom.setPrecioPaquete(rs.getDouble("precioPaquete"));
                prom.setImagen(rs.getString("imagen"));
                prom.setCategoria(rs.getString("categoria"));
                prom.setDetallePaquete(rs.getString("detallePaquete"));
                promociones.add(prom);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar paquetes (Promociones) con filtros: " + e.getMessage());
        }
        return promociones;
    }

    /**
     * Lista los paquetes INTERNACIONALES (categoria='I') con filtros.
     */
    public List listInt(String nombre, String precio, String orden) {
        List<Paquete> internacional = new ArrayList<>();
        List<Object> params = new ArrayList<>(); // Lista para los parámetros del PreparedStatement

        //Consulta SQL base
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE categoria='I'";

        // --- Construcción dinámica de la consulta ---
        // 1. Filtro por Nombre
        if (nombre != null && !nombre.isEmpty()) {
            cadSQL += " AND nombrePaquete LIKE ?";
            params.add("%" + nombre + "%");
        }

        // 2. Filtro por Precio
        if (precio != null && !precio.isEmpty()) {
            switch (precio) {
                case "100":
                    cadSQL += " AND precioPaquete < 100";
                    break;
                case "200":
                    cadSQL += " AND precioPaquete >= 100 AND precioPaquete <= 200";
                    break;
                case "201":
                    cadSQL += " AND precioPaquete > 200";
                    break;
            }
        }

        // 3. Ordenamiento
        if (orden != null && !orden.isEmpty()) {
            switch (orden) {
                case "precio_asc":
                    cadSQL += " ORDER BY precioPaquete ASC";
                    break;
                case "precio_desc":
                    cadSQL += " ORDER BY precioPaquete DESC";
                    break;
                case "nombre_asc":
                    cadSQL += " ORDER BY nombrePaquete ASC";
                    break;
            }
        }

        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);

            // Asignar los parámetros dinámicos
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Paquete tur = new Paquete();
                tur.setIdPaquete(rs.getInt("idPaquete"));
                tur.setNombrePaquete(rs.getString("nombrePaquete"));
                tur.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                tur.setPrecioPaquete(rs.getDouble("precioPaquete"));
                tur.setImagen(rs.getString("imagen"));
                tur.setCategoria(rs.getString("categoria"));
                tur.setDetallePaquete(rs.getString("detallePaquete"));
                internacional.add(tur);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar paquetes (Tours) con filtros: " + e.getMessage());
        }
        return internacional;
    }
    
    //Lista de todo los paquetes
    public List lista() {
        List<Paquete> paquetes = new ArrayList<>();
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete";
        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            while (rs.next()) {
                Paquete p = new Paquete();
                p.setIdPaquete(rs.getInt("idPaquete"));
                p.setNombrePaquete(rs.getString("nombrePaquete"));
                p.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                p.setPrecioPaquete(rs.getDouble("precioPaquete"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoria(rs.getString("categoria"));
                p.setDetallePaquete(rs.getString("detallePaquete"));
                paquetes.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar todos los paquetes: " + e.getMessage());
        }
        return paquetes;
    }

    // Lista de detalles paquetes
    public List listaDTP() {
        List<Paquete> detallePaquete = new ArrayList<>();
        String cadSQL = "SELECT idDetalle, itinerario, nombreHotel, imagenHotel, categoriaHotel, detalleHotel, inclusion FROM detalle_paquete";
        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            while (rs.next()) {
                Paquete p = new Paquete();
                p.setIdDetalle(rs.getInt("idDetalle"));
                p.setItinerario(rs.getString("itinerario"));
                p.setNombreHotel(rs.getString("nombreHotel"));
                p.setImagenHotel(rs.getString("imagenHotel"));
                p.setCategoriaHotel(rs.getString("categoriaHotel"));
                p.setDetalleHotel(rs.getString("detalleHotel"));
                p.setInclusion(rs.getString("inclusion"));
                detallePaquete.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar DTP: " + e.getMessage());
        }
        return detallePaquete;
    }

    public Paquete obtenerDetalle(int idPaquete) {
        Paquete p = null;
        String cadSQL = "SELECT "
                + "p.idPaquete, p.nombrePaquete, p.descripcionPaquete, p.precioPaquete, p.imagen, p.categoria, p.detallePaquete, "
                + "d.idDetalle, d.itinerario, d.nombreHotel, d.imagenHotel, d.categoriaHotel, d.detalleHotel, d.inclusion "
                + "FROM paquete p "
                + "JOIN detalle_paquete d ON p.idPaquete = d.idPaquete "
                + "WHERE p.idPaquete = ?";

        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);
            ps.setInt(1, idPaquete);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Paquete();
                p.setIdPaquete(rs.getInt("idPaquete"));
                p.setNombrePaquete(rs.getString("nombrePaquete"));
                p.setDescripcionPaquete(rs.getString("descripcionPaquete"));
                p.setPrecioPaquete(rs.getDouble("precioPaquete"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoria(rs.getString("categoria"));
                p.setDetallePaquete(rs.getString("detallePaquete"));
                p.setIdDetalle(rs.getInt("idDetalle"));
                p.setItinerario(rs.getString("itinerario"));
                p.setNombreHotel(rs.getString("nombreHotel"));
                p.setImagenHotel(rs.getString("imagenHotel"));
                p.setCategoriaHotel(rs.getString("categoriaHotel"));
                p.setDetalleHotel(rs.getString("detalleHotel"));
                p.setInclusion(rs.getString("inclusion"));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener detalle con JOIN: " + e.getMessage());
        }
        return p;
    }

    //Metodo para eliminar paquetes
    public String delete(int idp) {
        String resp = "";
        String cadSQL = "DELETE FROM paquete where idPaquete=?";
        try {
            ps = cnx.prepareStatement(cadSQL);
            ps.setInt(1, idp);
            int ctos = ps.executeUpdate();
            if (ctos == 0) {
                resp = "No se ha eliminado";
            }
            ps.close();
        } catch (SQLException ex) {
            resp = ex.getMessage();
        }
        return resp;
    }

    //Metodo para agregar nuevos paquetes
    public String insertUpdate(Paquete p) {
        String resp = "";
        String cadSQL = "";
        try {
            if (p.getIdPaquete() == 0) {
                cadSQL = "INSERT INTO paquete (nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete) VALUES(?,?,?,?,?,?)";
                ps = cnx.prepareStatement(cadSQL);
                ps.setString(1, p.getNombrePaquete());
                ps.setString(2, p.getDescripcionPaquete());
                ps.setDouble(3, p.getPrecioPaquete());
                ps.setString(4, p.getImagen());
                ps.setString(5, p.getCategoria());
                ps.setString(6, p.getDetallePaquete());
            } else {
                cadSQL = "UPDATE paquete SET nombrePaquete=?, descripcionPaquete=?, precioPaquete=?, imagen=?, categoria=?, detallePaquete=? WHERE idPaquete=?";
                ps = cnx.prepareStatement(cadSQL);
                ps.setString(1, p.getNombrePaquete());
                ps.setString(2, p.getDescripcionPaquete());
                ps.setDouble(3, p.getPrecioPaquete());
                ps.setString(4, p.getImagen());
                ps.setString(5, p.getCategoria());
                ps.setString(6, p.getDetallePaquete());
                ps.setInt(7, p.getIdPaquete());
            }

            int ctos = ps.executeUpdate();
            if (ctos > 0) {
                resp = "Registro exitoso";
            } else {
                resp = "No se ha registrado";
            }
        } catch (SQLException ex) {
            resp = "Error en la inserción o actualización: " + ex.getMessage();
        }
        return resp;
    }
}