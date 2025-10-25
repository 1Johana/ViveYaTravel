package com.mycompany.viveyatravel.modelo.dto;

import java.io.InputStream;

public class Paquete {
    // Atributos de la BD
    int idPaquete;
    String nombrePaquete;
    String descripcionPaquete;
    double precioPaquete;
    String imagen;
    String categoria;
    String detallePaquete;

    // Atributos para carrito
    int cantidad;
    double subtotal;

    // Constructor vacío
    public Paquete() {
    }

    // Constructor con BD
    public Paquete(int idPaquete, String nombrePaquete, String descripcionPaquete, double precioPaquete, String imagen, String categoria, String detallePaquete) {
        this.idPaquete = idPaquete;
        this.nombrePaquete = nombrePaquete;
        this.descripcionPaquete = descripcionPaquete;
        this.precioPaquete = precioPaquete;
        this.imagen = imagen;
        this.categoria = categoria;
        this.detallePaquete = detallePaquete;
    }

    // Getters y Setters de BD
    public int getIdPaquete() {
        return idPaquete;
    }

    public void setIdPaquete(int idPaquete) {
        this.idPaquete = idPaquete;
    }

    public String getNombrePaquete() {
        return nombrePaquete;
    }

    public void setNombrePaquete(String nombrePaquete) {
        this.nombrePaquete = nombrePaquete;
    }

    public String getDescripcionPaquete() {
        return descripcionPaquete;
    }

    public void setDescripcionPaquete(String descripcionPaquete) {
        this.descripcionPaquete = descripcionPaquete;
    }

    public double getPrecioPaquete() {
        return precioPaquete;
    }

    public void setPrecioPaquete(double precioPaquete) {
        this.precioPaquete = precioPaquete;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getDetallePaquete() {
        return detallePaquete;
    }

    public void setDetallePaquete(String detallePaquete) {
        this.detallePaquete = detallePaquete;
    }

    // Getters y Setters para carrito
    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
        this.subtotal = this.cantidad * this.precioPaquete; // recalculamos subtotal
    }

    public double getSubtotal() {
        return subtotal;
    }
}
