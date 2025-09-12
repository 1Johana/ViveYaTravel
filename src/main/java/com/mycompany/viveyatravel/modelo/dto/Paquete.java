package com.mycompany.viveyatravel.modelo.dto;

public class Paquete {
    //Atributos 
    int idPaquete;
    String nombrePaquete;
    String descripcionPaquete;
    double precioPaquete;
    String imagen;
    String categoria;
    String detallePaquete;

    //Constructor
    public Paquete() {
    }

    public Paquete(int idPaquete, String nombrePaquete, String descripcionPaquete, double precioPaquete, String imagen, String categoria, String detallePaquete) {
        this.idPaquete = idPaquete;
        this.nombrePaquete = nombrePaquete;
        this.descripcionPaquete = descripcionPaquete;
        this.precioPaquete = precioPaquete;
        this.imagen = imagen;
        this.categoria = categoria;
        this.detallePaquete = detallePaquete;
    }

    //Métodos getter y setter
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

    
    
}
