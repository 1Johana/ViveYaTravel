package com.mycompany.viveyatravel.modelo.dao;

import com.mycompany.viveyatravel.modelo.dto.ReservaUsuarioDTO;
import com.mycompany.viveyatravel.servicios.ConectarBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/**
 * DAO de reservas.
 * Tabla: reserva(idReserva PK AI, idUsuario, idPaquete, idAsiento, estadoPago, fechaReserva)
 */
public class ReservaDAO {

    private final Connection cnx;

    public ReservaDAO() {
        this.cnx = new ConectarBD().getConexion();
    }

    /**
     * Crea una reserva y devuelve el id generado (o 0 si falla).
     */
    public int crear(int idUsuario, int idPaquete, int idAsiento, String estadoPago) {
        final String sql =
            "INSERT INTO reserva (idUsuario, idPaquete, idAsiento, estadoPago, fechaReserva) " +
            "VALUES (?, ?, ?, ?, NOW())";
        try (PreparedStatement ps = cnx.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idPaquete);
            ps.setInt(3, idAsiento);
            ps.setString(4, estadoPago);

            int filas = ps.executeUpdate();
            if (filas > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lista las reservas de un usuario con datos del paquete y asiento.
     */
    public List<ReservaUsuarioDTO> listarPorUsuario(int idUsuario) {
        List<ReservaUsuarioDTO> lista = new ArrayList<>();

        String sql =
            "SELECT r.idReserva, r.idUsuario, r.idPaquete, r.idAsiento, r.estadoPago, r.fechaReserva, " +
            "       p.nombrePaquete, p.precioPaquete, " +
            "       a.numero AS numeroAsiento " +         // ← tu tabla tiene 'numero', lo exponemos como 'numeroAsiento'
            "FROM reserva r " +
            "LEFT JOIN paquete p ON p.idPaquete = r.idPaquete " +
            "LEFT JOIN asiento a ON a.idAsiento = r.idAsiento " +
            "WHERE r.idUsuario = ? " +
            "ORDER BY r.fechaReserva DESC";

        try (PreparedStatement ps = cnx.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReservaUsuarioDTO dto = new ReservaUsuarioDTO();
                    dto.setIdReserva(rs.getInt("idReserva"));
                    dto.setIdUsuario(rs.getInt("idUsuario"));
                    dto.setIdPaquete(rs.getInt("idPaquete"));
                    dto.setIdAsiento(rs.getInt("idAsiento"));
                    dto.setEstadoPago(rs.getString("estadoPago"));
                    dto.setFechaReserva(rs.getTimestamp("fechaReserva"));
                    dto.setNombrePaquete(rs.getString("nombrePaquete"));
                    dto.setPrecioPaquete(rs.getDouble("precioPaquete"));
                    dto.setNumeroAsiento(rs.getString("numeroAsiento")); // ← viene del alias
                    lista.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
