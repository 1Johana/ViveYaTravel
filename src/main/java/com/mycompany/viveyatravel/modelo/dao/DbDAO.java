package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class DbDAO {

    // 1) Reservas de HOY
    public int getBookingsToday() {
        int total = 0;

        String sql = "SELECT COUNT(*) "
                   + "FROM reserva "
                   + "WHERE DATE(fechaReserva) = CURDATE()";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error getBookingsToday: " + e.getMessage());
        }
        return total;
    }

    // 2) Número de reservas por estadoPago (pagado, pendiente, cancelado)
    public int getCountByStatus(String status) {
        int total = 0;

        String sql = "SELECT COUNT(*) "
                   + "FROM reserva "
                   + "WHERE estadoPago = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error getCountByStatus: " + e.getMessage());
        }

        return total;
    }

    // 3) Ingresos por paquete (usamos nombrePaquete y precioPaquete)
    public Map<String, Integer> getIncomeByDestination() {
        Map<String, Integer> map = new HashMap<>();

        String sql = "SELECT p.nombrePaquete AS destino, "
                   + "       SUM(p.precioPaquete) AS total "
                   + "FROM reserva r "
                   + "JOIN paquete p ON r.idPaquete = p.idPaquete "
                   + "GROUP BY p.nombrePaquete";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String destino = rs.getString("destino");
                int total = rs.getInt("total");
                map.put(destino, total);
            }

        } catch (Exception e) {
            System.out.println("Error getIncomeByDestination: " + e.getMessage());
        }

        return map;
    }

    // 4) TOTAL de usuarios (tabla: usuario)
    public int getTotalUsers() {
        int total = 0;

        String sql = "SELECT COUNT(*) FROM usuario";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error getTotalUsers: " + e.getMessage());
        }

        return total;
    }

    // 5) TOTAL de reclamos (tabla: reclamaciones)
    public int getTotalReclamaciones() {
        int total = 0;

        String sql = "SELECT COUNT(*) FROM reclamaciones";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error getTotalReclamaciones: " + e.getMessage());
        }

        return total;
    }
}
