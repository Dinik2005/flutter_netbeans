package com.matakuliah.matakuliah.request;

public class MatakuliahRequest {
    private String kode;
    private String nama;

    public MatakuliahRequest(String kode, String nama) {
        this.kode = kode;
        this.nama = nama;
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

    @Override
    public String toString() {
        return "MatakuliahRequest{" + "kode=" + kode + ", nama=" + nama + '}';
    }


}
