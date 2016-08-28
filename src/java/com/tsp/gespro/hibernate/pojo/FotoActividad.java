package com.tsp.gespro.hibernate.pojo;
// Generated 28/08/2016 12:38:26 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * FotoActividad generated by hbm2java
 */
public class FotoActividad  implements java.io.Serializable {


     private int id;
     private Integer idActividad;
     private String foto;
     private Integer idProyecto;
     private Integer idPromotor;
     private Integer idPunto;
     private Integer tipoActividad;
     private Date fecha;

    public FotoActividad() {
    }

	
    public FotoActividad(int id) {
        this.id = id;
    }
    public FotoActividad(int id, Integer idActividad, String foto, Integer idProyecto, Integer idPromotor, Integer idPunto, Integer tipoActividad, Date fecha) {
       this.id = id;
       this.idActividad = idActividad;
       this.foto = foto;
       this.idProyecto = idProyecto;
       this.idPromotor = idPromotor;
       this.idPunto = idPunto;
       this.tipoActividad = tipoActividad;
       this.fecha = fecha;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public Integer getIdActividad() {
        return this.idActividad;
    }
    
    public void setIdActividad(Integer idActividad) {
        this.idActividad = idActividad;
    }
    public String getFoto() {
        return this.foto;
    }
    
    public void setFoto(String foto) {
        this.foto = foto;
    }
    public Integer getIdProyecto() {
        return this.idProyecto;
    }
    
    public void setIdProyecto(Integer idProyecto) {
        this.idProyecto = idProyecto;
    }
    public Integer getIdPromotor() {
        return this.idPromotor;
    }
    
    public void setIdPromotor(Integer idPromotor) {
        this.idPromotor = idPromotor;
    }
    public Integer getIdPunto() {
        return this.idPunto;
    }
    
    public void setIdPunto(Integer idPunto) {
        this.idPunto = idPunto;
    }
    public Integer getTipoActividad() {
        return this.tipoActividad;
    }
    
    public void setTipoActividad(Integer tipoActividad) {
        this.tipoActividad = tipoActividad;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }




}


