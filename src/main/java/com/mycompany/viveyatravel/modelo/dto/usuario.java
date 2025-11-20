package com.mycompany.viveyatravel.modelo.dto;

public class usuario {
    private int idUsuario;
    private String nombre;
    private String apellido;
    private int nroCelular;
    private int nroDni;
    private String correoElectronico;
    private String clave;
    private String genero;
    private cargo cargo;
    
    // Nuevo campo para foto
    private byte[] fotoPerfil;

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public int getNroCelular() { return nroCelular; }
    public void setNroCelular(int nroCelular) { this.nroCelular = nroCelular; }

    public int getNroDni() { return nroDni; }
    public void setNroDni(int nroDni) { this.nroDni = nroDni; }

    public String getCorreoElectronico() { return correoElectronico; }
    public void setCorreoElectronico(String correoElectronico) { this.correoElectronico = correoElectronico; }

    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }

    public cargo getCargo() { return cargo; }
    public void setCargo(cargo cargo) { this.cargo = cargo; }

    public byte[] getFotoPerfil() { return fotoPerfil; }
    public void setFotoPerfil(byte[] fotoPerfil) { this.fotoPerfil = fotoPerfil; }
}

