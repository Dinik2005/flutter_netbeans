import 'package:flutter_application_crud/nilaikuliah/mainnilaikuliah.dart';

class NilaiKuliah {
  int id;
  int idmahasiswa; // Ganti dengan tipe data yang sesuai
  int idmatakuliah; // Ganti dengan tipe data yang sesuai
  double nilai; // Ganti dengan tipe data yang sesuai

  NilaiKuliah({
    required this.id,
    required this.idmahasiswa,
    required this.idmatakuliah,
    required this.nilai,
  });

  factory NilaiKuliah.fromJson(Map<String, dynamic> json) {
    return NilaiKuliah(
      id: json['id'],
      idmahasiswa: json['idmahasiswa'],
      idmatakuliah: json['idmatakuliah'],
      nilai: json['nilai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idmahasiswa': idmahasiswa,
      'idmatakuliah': idmatakuliah,
      'nilai': nilai,
    };
  }
}
