package com.mycompany.viveyatravel.modelo.dto;

import java.sql.Timestamp;

public class ReservaView {
    private int idReserva;
    private String nombrePaquete;
    private String numeroAsiento; // puede ser null si no aplica
    private String estadoPago;
    private Timestamp fechaReserva;
    private double precioPaquete;

    public int getIdReserva() { return idReserva; }
    public void setIdReserva(int idReserva) { this.idReserva = idReserva; }

    public String getNombrePaquete() { return nombrePaquete; }
    public void setNombrePaquete(String nombrePaquete) { this.nombrePaquete = nombrePaquete; }

    public String getNumeroAsiento() { return numeroAsiento; }
    public void setNumeroAsiento(String numeroAsiento) { this.numeroAsiento = numeroAsiento; }

    public String getEstadoPago() { return estadoPago; }
    public void setEstadoPago(String estadoPago) { this.estadoPago = estadoPago; }

    public Timestamp getFechaReserva() { return fechaReserva; }
    public void setFechaReserva(Timestamp fechaReserva) { this.fechaReserva = fechaReserva; }

    public double getPrecioPaquete() { return precioPaquete; }
    public void setPrecioPaquete(double precioPaquete) { this.precioPaquete = precioPaquete; }
}
