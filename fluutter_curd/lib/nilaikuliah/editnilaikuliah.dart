import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilaikuliah/nilaikuliah.dart';
import 'package:flutter_application_crud/nilaikuliah/apinilaikuliah.dart';

class EditNilaiKuliah extends StatefulWidget {
  final int id;
  final int idMahasiswa;
  final int idMatakuliah;
  final double nilai;

  EditNilaiKuliah(this.id, this.idMahasiswa, this.idMatakuliah, this.nilai);

  @override
  State<EditNilaiKuliah> createState() => _EditNilaiKuliahState();
}

class _EditNilaiKuliahState extends State<EditNilaiKuliah> {
  final ApiService _apiService = ApiService();
  TextEditingController _idMahasiswaController = TextEditingController();
  TextEditingController _idMatakuliahController = TextEditingController();
  TextEditingController _nilaiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idMahasiswaController.text = widget.idMahasiswa.toString();
    _idMatakuliahController.text = widget.idMatakuliah.toString();
    _nilaiController.text = widget.nilai.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Nilai Kuliah'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _idMahasiswaController,
                decoration: InputDecoration(labelText: 'ID Mahasiswa'),
              ),
              TextFormField(
                controller: _idMatakuliahController,
                decoration: InputDecoration(labelText: 'ID Matakuliah'),
              ),
              TextFormField(
                controller: _nilaiController,
                decoration: InputDecoration(labelText: 'Nilai'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Melakukan update data NilaiKuliah
                  NilaiKuliah editedNilaiKuliah = NilaiKuliah(
                    id: widget.id,
                    idmahasiswa: int.parse(_idMahasiswaController.text),
                    idmatakuliah: int.parse(_idMatakuliahController.text),
                    nilai: double.parse(_nilaiController.text),
                  );

                  print(_idMahasiswaController.text);

                  print("Post updated successfully");

                  NilaiKuliah editedPost =
                  await _apiService.updateNilaiKuliah(editedNilaiKuliah);
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
