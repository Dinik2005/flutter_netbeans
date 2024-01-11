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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _kodeController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _sksController = TextEditingController();

  int idMataKuliah = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Id data : $idMataKuliah"),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ID tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kodeController,
                    decoration: const InputDecoration(labelText: 'Kode'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kode tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _sksController,
                    decoration: const InputDecoration(labelText: 'SKS'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'SKS tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Proses pembuatan Mata Kuliah baru
                            int id = int.parse(_idController.text);
                            String kode = _kodeController.text;
                            String nama = _namaController.text;
                            int sks = int.parse(_sksController.text);

                            MataKuliah newMataKuliah = MataKuliah(
                              id: id,
                              kode: kode,
                              nama: nama,
                              sks: sks,
                            );

                            await _apiService.createMataKuliah(newMataKuliah);

                            _idController.clear();
                            _kodeController.clear();
                            _namaController.clear();
                            _sksController.clear();

                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.add),
                        tooltip: 'Create MataKuliah',
                      ),
                      IconButton(
                        onPressed: () {
                          _idController.clear();
                          _kodeController.clear();
                          _namaController.clear();
                          _sksController.clear();
                          setState(() {
                            idMataKuliah = 0;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Refresh',
                      ),
                      IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            int id = int.parse(_idController.text);
                            String kode = _kodeController.text;
                            String nama = _namaController.text;
                            int sks = int.parse(_sksController.text);

                            MataKuliah updatedMataKuliah = MataKuliah(
                              id: id,
                              kode: kode,
                              nama: nama,
                              sks: sks,
                            );

                            await _apiService.updateMataKuliah(updatedMataKuliah);

                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.edit),
                        tooltip: 'Edit MataKuliah',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: FutureBuilder<List<MataKuliah>>(
                future: _apiService.getMataKuliah(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<MataKuliah> mataKuliahs = snapshot.data!;
                    return ListView.builder(
                      itemCount: mataKuliahs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(mataKuliahs[index].nama),
                          subtitle: Text(mataKuliahs[index].kode),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  try {
                                    await _apiService.deleteMataKuliah(mataKuliahs[index].id);
                                    setState(() {});
                                  } catch (e) {
                                    print('Error deleting data: $e');
                                  }
                                },
                                icon: const Icon(Icons.delete),
                                tooltip: 'Delete',
                              ),
                              IconButton(
                                onPressed: () {
                                  idMataKuliah = mataKuliahs[index].id;
                                  _idController.text = mataKuliahs[index].id.toString();
                                  _kodeController.text = mataKuliahs[index].kode;
                                  _namaController.text = mataKuliahs[index].nama;
                                  _sksController.text = mataKuliahs[index].sks.toString();

                                  setState(() {
                                    idMataKuliah = mataKuliahs[index].id;
                                  });
                                },
                                icon: const Icon(Icons.edit),
                                tooltip: 'Edit',
                              ),
                            ],
                          ),
                          onTap: () {
                            idMataKuliah = mataKuliahs[index].id;
                            _idController.text = mataKuliahs[index].id.toString();
                            _kodeController.text = mataKuliahs[index].kode;
                            _namaController.text = mataKuliahs[index].nama;
                            _sksController.text = mataKuliahs[index].sks.toString();

                            setState(() {
                              idMataKuliah = mataKuliahs[index].id;
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
