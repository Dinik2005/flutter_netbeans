import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah/matakuliah.dart';
import 'package:flutter_application_crud/matakuliah/apimatakuliah.dart';

void main() {
  runApp(const MataKuliahApp());
}

class MataKuliahApp extends StatelessWidget {
  const MataKuliahApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  TextEditingController _kodeController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _sksController = TextEditingController();

  int idMataKuliah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Matakuliah'),
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
                    controller: _kodeController,
                    decoration: InputDecoration(labelText: 'Kode'),
                  ),
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(labelText: 'Nama matakuliah'),
                  ),
                  TextFormField(
                    controller: _sksController,
                    decoration: InputDecoration(labelText: 'sks'),
                  ),

                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
//refresh
                      TextButton(
                        onPressed: () {
                          _kodeController.clear();
                          _namaController.clear();
                          _sksController.clear();

                          setState(() {
                            idMataKuliah = 0;
                          });
                        },
                        child: Text('Refresh Data'),
                      ),

// Tambah data
                      IconButton(
                        onPressed: () async {
                          MataKuliah newPost = MataKuliah(
                            id: 0,
                            kode: _kodeController.text,
                            nama: _namaController.text,
                            sks: int.parse(_sksController.text),
                          );

                          await _apiService.createMataKuliah(newPost);

                          _kodeController.clear();
                          _namaController.clear();
                          _sksController.clear();

                          setState(() {});
                          await _apiService.getMataKuliah();
                        },
                        icon: Icon(Icons.add),
                        tooltip: 'Tambah Data',
                      ),

// Update data
                      IconButton(
                        onPressed: () async {
                          MataKuliah editPost = MataKuliah(
                            id: idMataKuliah,
                            kode: _kodeController.text,
                            nama: _namaController.text,
                            sks: int.parse(_sksController.text),
                          );

                          print(_namaController.text);
                          print("Post Updated SuccesssFull");
                          setState(() {
                            idMataKuliah = 0;
                          });
                          _kodeController.clear();
                          _namaController.clear();
                          _sksController.clear();

                          MataKuliah editedPost =
                          await _apiService.updateMataKuliah(editPost);
                          await _apiService.getMataKuliah();
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

          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder<List<MataKuliah>>(
                future: _apiService.getMataKuliah(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<MataKuliah> posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(posts[index].kode),
                          subtitle: Text(posts[index].nama),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await _apiService.deleteMataKuliah(posts[index].id);
                                  setState(() {});
                                  await _apiService.getMataKuliah();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                tooltip: 'Delete Data',
                              ),

                            ],
                          ),
                          onTap: () async {
                            MataKuliah selectedMatakuliah =
                            await _apiService.getMataKuliahById(posts[index].id);

                            idMataKuliah = selectedMatakuliah.id;
                            _kodeController.text = selectedMatakuliah.kode;
                            _namaController.text = selectedMatakuliah.nama;
                            _sksController.text = selectedMatakuliah.sks.toString();

                            await _apiService.getMataKuliah();

                            setState(() {
                              idMataKuliah = selectedMatakuliah.id;
                              print(idMataKuliah);
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
