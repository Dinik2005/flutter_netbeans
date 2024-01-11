package com.matakuliah.matakuliah.request;

public class MatakuliahRequest {
    private String kode;
    private String nama;
    private int sks;

    // Constructors, getters, and setters

    public MatakuliahRequest() {
    }

    public MatakuliahRequest(String kode, String nama, int sks) {
        this.kode = kode;
        this.nama = nama;
        this.sks = sks;
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
        return "MatakuliahRequest{" +
                "kode='" + kode + '\'' +
                ", nama='" + nama + '\'' +
                ", sks=" + sks +
                '}';
    }
}
