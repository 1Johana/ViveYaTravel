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
        //Paquete p = new Paquete();
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
        }
        return p;
    }

    //Para poner dentro de una lista los tours registrados
    public List listar() {
        List<Paquete> lista = new ArrayList<>();
        //Consulta SQL para mostrar
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE categoria='T'";
        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);
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
        }
        return lista;
    }

    //Para poner dentro de una lista las promociones registrados
    public List list() {
        List<Paquete> promociones = new ArrayList<>();
        //Consulta SQL para mostrar
        String cadSQL = "SELECT idPaquete, nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete FROM paquete WHERE categoria='P'";
        try {
            cnx = cn.getConexion();
            ps = cnx.prepareStatement(cadSQL);
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
        }
        return promociones;
    }

    //Lista de todo los paquetes
    public List lista() {
        List<Paquete> paquetes = new ArrayList<>();
        //Consulta SQL para mostrar
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
        }
        return paquetes;
    }

    //Metodo para eliminar paquetes
    public String delete(int idp) {
        String resp = "";
        //PreparedStatement ps;
        //ResultSet rs;
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
                // Es una inserción
                cadSQL = "INSERT INTO paquete (nombrePaquete, descripcionPaquete, precioPaquete, imagen, categoria, detallePaquete) VALUES(?,?,?,?,?,?)";
                ps = cnx.prepareStatement(cadSQL);

                ps.setString(1, p.getNombrePaquete());
                ps.setString(2, p.getDescripcionPaquete());
                ps.setDouble(3, p.getPrecioPaquete());
                ps.setString(4, p.getImagen());
                ps.setString(5, p.getCategoria());
                ps.setString(6, p.getDetallePaquete());
            } else {
                // Es una actualización
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
