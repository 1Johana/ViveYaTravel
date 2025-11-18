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
    
    //Detalle Paquete 
    
    int idDetalle; 
    String itinerario;
    String nombreHotel;
    String imagenHotel;
    String categoriaHotel;
    String detalleHotel;
    String inclusion;
    



    // Atributos para carrito

    int cantidad;

    double subtotal;



    // Constructor vacío

    public Paquete() {

    }



    // Constructor con BD

    public Paquete(int idPaquete, String nombrePaquete, String descripcionPaquete, double precioPaquete, String imagen, String categoria, String detallePaquete, int idDetalle, String itinerario, String nombreHotel, String imagenHotel, String categoriaHotel, String detalleHotel, String inclusion, int cantidad, double subtotal) {
        this.idPaquete = idPaquete;
        this.nombrePaquete = nombrePaquete;
        this.descripcionPaquete = descripcionPaquete;
        this.precioPaquete = precioPaquete;
        this.imagen = imagen;
        this.categoria = categoria;
        this.detallePaquete = detallePaquete;
        this.idDetalle = idDetalle;
        this.itinerario = itinerario;
        this.nombreHotel = nombreHotel;
        this.imagenHotel = imagenHotel;
        this.categoriaHotel = categoriaHotel;
        this.detalleHotel = detalleHotel;
        this.inclusion = inclusion;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
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

// G&T Detalle Paquete

    public int getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = idDetalle;
    }

    public String getItinerario() {
        return itinerario;
    }

    public void setItinerario(String itinerario) {
        this.itinerario = itinerario;
    }

    public String getNombreHotel() {
        return nombreHotel;
    }

    public void setNombreHotel(String nombreHotel) {
        this.nombreHotel = nombreHotel;
    }

    public String getImagenHotel() {
        return imagenHotel;
    }

    public void setImagenHotel(String imagenHotel) {
        this.imagenHotel = imagenHotel;
    }

    public String getCategoriaHotel() {
        return categoriaHotel;
    }

    public void setCategoriaHotel(String categoriaHotel) {
        this.categoriaHotel = categoriaHotel;
    }

    public String getDetalleHotel() {
        return detalleHotel;
    }

    public void setDetalleHotel(String detalleHotel) {
        this.detalleHotel = detalleHotel;
    }

    public String getInclusion() {
        return inclusion;
    }

    public void setInclusion(String inclusion) {
        this.inclusion = inclusion;
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