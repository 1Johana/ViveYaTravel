/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.viveyatravel.modelo.dto;

/**
 *
 * @author Lenovo
 */
public class Reclamacion {
    private int id;
    private String nombre;
    private String dni;
    private String direccion;
    private String distrito;
    private String telefono;
    private String email;
    private String tipoBien;
    private String descripcionBien;
    private String tipoReclamo;
    private String detalleReclamo;

    // Getters y setters
     public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDni() {
        return dni;
    }
    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDistrito() {
        return distrito;
    }
    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getTelefono() {
        return telefono;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getTipoBien() {
        return tipoBien;
    }
    public void setTipoBien(String tipoBien) {
        this.tipoBien = tipoBien;
    }

    public String getDescripcionBien() {
        return descripcionBien;
    }
    public void setDescripcionBien(String descripcionBien) {
        this.descripcionBien = descripcionBien;
    }

    public String getTipoReclamo() {
        return tipoReclamo;
    }
    public void setTipoReclamo(String tipoReclamo) {
        this.tipoReclamo = tipoReclamo;
    }

    public String getDetalleReclamo() {
        return detalleReclamo;
    }
    public void setDetalleReclamo(String detalleReclamo) {
        this.detalleReclamo = detalleReclamo;
    }
}