package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.DBConnection;
import java.sql.*;
import java.util.*;

public class ReservaaDAO {

    public static class Reservaa {
        public int id;
        public String cliente;
        public String destino;
        public double precio;
        public String fecha;
        public String estado;
    }

    public List<Reservaa> getRecentReservations() {
        List<Reservaa> list = new ArrayList<>();

        String sql = "SELECT id, cliente, destino, precio, fecha, estado "
                   + "FROM reservas ORDER BY fecha DESC LIMIT 10";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reservaa r = new Reservaa();
                r.id = rs.getInt("id");
                r.cliente = rs.getString("cliente");
                r.destino = rs.getString("destino");
                r.precio = rs.getDouble("precio");
                r.fecha = rs.getString("fecha");
                r.estado = rs.getString("estado");
                list.add(r);
            }

        } catch (Exception e) {
            System.out.println("Error getRecentReservations: " + e.getMessage());
        }

        return list;
    }
}
