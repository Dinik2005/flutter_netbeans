import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah/matakuliah.dart';
import 'package:flutter_application_crud/matakuliah/apimatakuliah.dart';

class Update extends StatefulWidget {
  final int id;
  final String kode;
  final String nama;
  final int sks;

  Update(this.id, this.kode, this.nama, this.sks);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final ApiService _apiService = ApiService();
  TextEditingController _kodeController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _sksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _kodeController.text = widget.kode;
    _namaController.text = widget.nama;
    _sksController.text = widget.sks.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _kodeController,
                decoration: InputDecoration(labelText: 'Kode'),
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: _sksController,
                decoration: InputDecoration(labelText: 'SKS'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Melakukan update data MataKuliah
                  MataKuliah updatedMataKuliah = MataKuliah(
                    id: widget.id,
                    kode: _kodeController.text,
                    nama: _namaController.text,
                    sks: int.tryParse(_sksController.text) ?? 0,
                  );

                  await _apiService.updateMataKuliah(updatedMataKuliah);

                  // Setelah update, Anda dapat melakukan apa yang diperlukan, seperti navigasi ke layar lain atau pembaruan tampilan.
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
