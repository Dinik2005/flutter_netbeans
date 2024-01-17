import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilaikuliah/nilaikuliah.dart';
import 'package:flutter_application_crud/nilaikuliah/apinilaikuliah.dart';
import 'package:flutter_application_crud/nilaikuliah/editnilaikuliah.dart';

void main() {
  runApp(NilaiKuliahApp());
}

class NilaiKuliahApp extends StatelessWidget {
  const NilaiKuliahApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NilaiKuliahHomePage(),

    );
  }
}

class NilaiKuliahHomePage extends StatefulWidget {
  const NilaiKuliahHomePage({Key? key});
  @override
  _NilaiKuliahHomePageState createState() => _NilaiKuliahHomePageState();
}

class _NilaiKuliahHomePageState extends State<NilaiKuliahHomePage> {
  final ApiService _apiService = ApiService();
  TextEditingController _idMahasiswaController = TextEditingController();
  TextEditingController _idMatakuliahController = TextEditingController();
  TextEditingController _nilaiController = TextEditingController();

  int idNilaiKuliah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai Kuliah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
//refresh data bukan recal-recal depan turet
                      TextButton(
                        onPressed: () {
                          _idMahasiswaController.clear();
                          _idMatakuliahController.clear();
                          _nilaiController.clear();
                          setState(() {
                            idNilaiKuliah = 0;
                          });
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.green, // Set the text color
                        ),
                        child: Text('Refresh Data'),
                      ),
//tambah data
                      IconButton(
                        onPressed: () async {
                          NilaiKuliah newPost = NilaiKuliah(
                            id: 0,
                            idmahasiswa: int.parse(_idMahasiswaController.text),
                            idmatakuliah: int.parse(_idMatakuliahController.text),
                            nilai: double.parse(_nilaiController.text),
                          );

                          await _apiService.createNilaiKuliah(newPost);

                          _idMahasiswaController.clear();
                          _idMatakuliahController.clear();
                          _nilaiController.clear();

                          setState(() {});
                          await _apiService.getNilaiKuliah();
                        },
                        icon: Icon(Icons.add),
                        tooltip: 'Tambah Data',
                      ),
//edit data
                      IconButton(
                        onPressed: () async {
                          NilaiKuliah editPost = NilaiKuliah(
                            id: idNilaiKuliah,
                            idmahasiswa: int.parse(_idMahasiswaController.text),
                            idmatakuliah: int.parse(_idMatakuliahController.text),
                            nilai: double.parse(_nilaiController.text),
                          );

                          print(_idMahasiswaController.text);

                          print("Post updated successfully");

                          setState(() {
                            idNilaiKuliah = 0;
                          });

                          _idMahasiswaController.clear();
                          _idMatakuliahController.clear();
                          _nilaiController.clear();

                          // Await the update operation
                          await _apiService.updateNilaiKuliah(editPost);

                          // Update the UI state
                          setState(() {});
                        },
                        icon: Icon(Icons.edit),
                        tooltip: 'Edit Data',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

//delete
          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder<List<NilaiKuliah>>(
                future: _apiService.getNilaiKuliah(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<NilaiKuliah> posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(posts[index].idmahasiswa.toString()),
                          subtitle: Text(posts[index].idmatakuliah.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  _apiService.deleteNilaiKuliah(posts[index].id);
                                  _apiService.getNilaiKuliah();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                tooltip: 'Delete',
                              ),
                            ],
                          ),

//Data bukan fakta coplak

                          onTap: () async {
                            NilaiKuliah selectedNilaiKuliah = await _apiService
                                .getNilaiKuliahById(posts[index].id);

                            idNilaiKuliah = selectedNilaiKuliah.id;
                            _idMahasiswaController.text =
                                selectedNilaiKuliah.idmahasiswa.toString();
                            _idMatakuliahController.text =
                                selectedNilaiKuliah.idmatakuliah.toString();
                            _nilaiController.text =
                                selectedNilaiKuliah.nilai.toString();

                            _apiService.getNilaiKuliah();

                            setState(() {
                              idNilaiKuliah = selectedNilaiKuliah.id;
                              print(idNilaiKuliah);
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
