package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.Asiento;
import com.mycompany.viveyatravel.servicios.ConectarBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsientoDAO {

    private Connection cnx;

    public AsientoDAO() {
        try {
            cnx = new ConectarBD().getConexion();
        } catch (Exception e) {
            cnx = null;
            e.printStackTrace();
        }
    }

    // 🔹 Listar todos los asientos de un bus
    public List<Asiento> listarPorBus(int idBus) {
        List<Asiento> lista = new ArrayList<>();
        if (cnx == null) return lista;
        String sql = "SELECT idAsiento, idBus, numero, estado FROM asiento WHERE idBus = ? ORDER BY idAsiento";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idBus);
            rs = ps.executeQuery();
            while (rs.next()) {
                Asiento a = new Asiento();
                a.setIdAsiento(rs.getInt("idAsiento"));
                a.setIdBus(rs.getInt("idBus"));
                a.setNumero(rs.getString("numero"));
                a.setEstado(rs.getString("estado"));
                lista.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
        }
        return lista;
    }

    // 🔹 Obtener un asiento específico por ID
    public Asiento obtener(int idAsiento) {
        Asiento a = null;
        if (cnx == null) return null;
        String sql = "SELECT idAsiento, idBus, numero, estado FROM asiento WHERE idAsiento = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idAsiento);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new Asiento();
                a.setIdAsiento(rs.getInt("idAsiento"));
                a.setIdBus(rs.getInt("idBus"));
                a.setNumero(rs.getString("numero"));
                a.setEstado(rs.getString("estado"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
        }
        return a;
    }

    // 🔹 Marcar asiento como ocupado
    public boolean ocuparAsiento(int idAsiento) {
        if (cnx == null) return false;
        String sql = "UPDATE asiento SET estado = 'ocupado' WHERE idAsiento = ? AND estado = 'libre'";
        PreparedStatement ps = null;
        try {
            ps = cnx.prepareStatement(sql);
            ps.setInt(1, idAsiento);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
        }
    }
}
