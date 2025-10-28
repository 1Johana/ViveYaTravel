package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.Reclamacion;
import com.mycompany.viveyatravel.servicios.ConectarBD;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReclamacionDAO {
    
    private Connection conexion;

    // Constructor: abrir conexión
    public ReclamacionDAO() {
        conexion = new ConectarBD().getConexion();
    }

    // Insertar nuevo reclamo en el Libro de Reclamaciones
    public void insertar(Reclamacion r) {
        String sql = "INSERT INTO reclamaciones(nombre, dni, direccion, distrito, telefono, email, tipo_bien, descripcion_bien, tipo_reclamo, detalle_reclamo, fecha_registro) VALUES(?,?,?,?,?,?,?,?,?,?, NOW())";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, r.getNombre());
            ps.setString(2, r.getDni());
            ps.setString(3, r.getDireccion());
            ps.setString(4, r.getDistrito());
            ps.setString(5, r.getTelefono());
            ps.setString(6, r.getEmail());
            ps.setString(7, r.getTipoBien());
            ps.setString(8, r.getDescripcionBien());
            ps.setString(9, r.getTipoReclamo());
            ps.setString(10, r.getDetalleReclamo());
            ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ReclamacionDAO.class.getName()).log(Level.SEVERE, "Error insertando reclamo", e);
        }
    }

    // Obtener todos los reclamos
    public List<Reclamacion> obtenerTodos() {
        List<Reclamacion> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, dni, direccion, distrito, telefono, email, tipo_bien, descripcion_bien, tipo_reclamo, detalle_reclamo, fecha_registro FROM reclamaciones";
        try (Statement st = conexion.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Reclamacion r = new Reclamacion();
                r.setId(rs.getInt("id"));
                r.setNombre(rs.getString("nombre"));
                r.setDni(rs.getString("dni"));
                r.setDireccion(rs.getString("direccion"));
                r.setDistrito(rs.getString("distrito"));
                r.setTelefono(rs.getString("telefono"));
                r.setEmail(rs.getString("email"));
                r.setTipoBien(rs.getString("tipo_Bien"));
                r.setDescripcionBien(rs.getString("descripcion_bien"));
                r.setTipoReclamo(rs.getString("tipo_reclamo"));
                r.setDetalleReclamo(rs.getString("detalle_reclamo"));
                r.setFecha(rs.getString("fecha_registro"));
                lista.add(r);
            }
        } catch (SQLException e) {
            Logger.getLogger(ReclamacionDAO.class.getName()).log(Level.SEVERE, "Error obteniendo reclamos", e);
        }
        return lista;
    }
}