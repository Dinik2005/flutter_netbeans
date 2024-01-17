class MataKuliah {
  final int id;
  final String nama;
  final String kode;
  final int sks;

  MataKuliah({
    required this.id,
    required this.kode,
    required this.nama,
    required this.sks,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      id: json['id'] as int,
      nama: json['nama'] as String,
      kode: json['kode'] as String,
      sks: json['sks'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kode': kode,
      'sks': sks,
    };
  }
}
