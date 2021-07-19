package org.ruivaldez.bean;

public class ServicioHasPlato {
    private Integer codigoServicio;
    private Integer codigoPlato;

    public ServicioHasPlato() {
    }

    public ServicioHasPlato(Integer codigoServicio, Integer codigoPlato) {
        this.codigoServicio = codigoServicio;
        this.codigoPlato = codigoPlato;
    }

    public Integer getCodigoServicio() {
        return codigoServicio;
    }

    public void setCodigoServicio(Integer codigoServicio) {
        this.codigoServicio = codigoServicio;
    }

    public Integer getCodigoPlato() {
        return codigoPlato;
    }

    public void setCodigoPlato(Integer codigoPlato) {
        this.codigoPlato = codigoPlato;
    } 
    
}