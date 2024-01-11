class MataKuliah {
  final int id;
  final String nama;
  final String kode;
  final int sks; // Properti SKS ditambahkan

  MataKuliah({
    required this.id,
    required this.kode,
    required this.nama,
    required this.sks,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      id: json['id'],
      nama: json['nama'],
      kode: json['kode'],
      sks: json['sks'], // Mengambil nilai SKS dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kode': kode,
      'sks': sks, // Menambahkan nilai SKS ke JSON
    };
  }
}