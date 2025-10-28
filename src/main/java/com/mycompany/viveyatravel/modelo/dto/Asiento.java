package com.mycompany.viveyatravel.modelo.dto;

public class Asiento {
    private int idAsiento;
    private int idBus;
    private String numero;
    private String estado; // 'libre' | 'ocupado' | 'reservado'

    public Asiento() {}

    public int getIdAsiento() {
        return idAsiento;
    }

    public void setIdAsiento(int idAsiento) {
        this.idAsiento = idAsiento;
    }

    public int getIdBus() {
        return idBus;
    }

    public void setIdBus(int idBus) {
        this.idBus = idBus;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    // ✅ Alias agregado para compatibilidad con srvPromocion
    public String getNumeroAsiento() {
        return numero;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    // ✅ Método útil para saber si está ocupado o reservado
    public boolean isOcupado() {
        return "ocupado".equalsIgnoreCase(estado) || "reservado".equalsIgnoreCase(estado);
    }

    @Override
    public String toString() {
        return "Asiento{idAsiento=" + idAsiento +
                ", idBus=" + idBus +
                ", numero='" + numero + '\'' +
                ", estado='" + estado + '\'' +
                '}';
    }
}
