/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.nilai.nilai.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 *
 * @author LABP2COMDOSEN
 */
@Entity
@Table
public class Nilai {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long idmahasiswa;
    private Long idmatakuliah;
    private double Nilai;

    public Nilai() {
    }

    public Nilai(Long id, Long idmahasiswa, Long idmatakuliah, double Nilai) {
        this.id = id;
        this.idmahasiswa = idmahasiswa;
        this.idmatakuliah = idmatakuliah;
        this.Nilai = Nilai;
    }
    
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdmahasiswa() {
        return idmahasiswa;
    }

    public void setIdmahasiswa(Long idmahasiswa) {
        this.idmahasiswa = idmahasiswa;
    }

    public Long getIdmatakuliah() {
        return idmatakuliah;
    }

    public void setIdmatakuliah(Long idmatakuliah) {
        this.idmatakuliah = idmatakuliah;
    }

    public double getNilai() {
        return Nilai;
    }

    public void setNilai(double Nilai) {
        this.Nilai = Nilai;
    }

    @Override
    public String toString() {
        return "Nilai{" + "id=" + id + ", idmahasiswa=" + idmahasiswa + ", idmatakuliah=" + idmatakuliah + ", Nilai=" + Nilai + '}';
    }
    
}
