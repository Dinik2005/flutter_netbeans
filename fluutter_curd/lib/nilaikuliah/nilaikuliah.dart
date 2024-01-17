class NilaiKuliah {
  int id;
  int idmahasiswa;
  int idmatakuliah;
  double nilai;

  // Remove the idMahasiswa parameter from the constructor
  NilaiKuliah({
    required this.id,
    required this.idmahasiswa,
    required this.idmatakuliah,
    required this.nilai,
  });

  // Update the factory method to use the constructor parameters
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
