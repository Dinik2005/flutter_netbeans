/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.nilai.nilai.vo;

/**
 *
 * @author LABP2COMDOSEN
 */

public class Matakuliah {
   private Long id;
   private String kode;
   private String nama;
   private int sks;

    public Matakuliah() {
    }

    public Matakuliah(Long id, String kode, String nama, int sks) {
        this.id = id;
        this.kode = kode;
        this.nama = nama;
        this.sks = sks;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getKode() {
        return kode;
    }

    public void setKode(String kode) {
        this.kode = kode;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public int getSks() {
        return sks;
    }

    public void setSks(int sks) {
        this.sks = sks;
    }

    @Override
    public String toString() {
        return "Matakuliah{" + "id=" + id + ", kode=" + kode + ", nama=" + nama + ", sks=" + sks + '}';
    }
   
   
}
