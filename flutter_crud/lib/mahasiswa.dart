class Mahasiswa {
  int id;
  String nama;
  String email;
  String tgllahir;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.email,
    required this.tgllahir,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'] as int,
      nama: json['nama'] as String,
      email: json['email'] as String,
      tgllahir: json['tgllahir'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'tgllahir': tgllahir,
    };
  }
}
