import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilaikuliah/apinilaikuliah.dart';
import 'package:flutter_application_crud/nilaikuliah/nilaikuliah.dart';

void main() {
  runApp(const NilaiPage());
}

class NilaiPage extends StatelessWidget {
  const NilaiPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
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
  final TextEditingController _idMahasiswaController = TextEditingController();
  final TextEditingController _idMatakuliahController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();
  int? selectedNilaiId;

  List<NilaiKuliah> nilaiList = [];

  Future<void> _refreshData() async {
    setState(() {});
  }

  Future<void> _createOrUpdateNilai() async {
    final String idMahasiswa = _idMahasiswaController.text;
    final String idMatakuliah = _idMatakuliahController.text;
    final String nilai = _nilaiController.text;

    if (idMahasiswa.isEmpty || idMatakuliah.isEmpty || nilai.isEmpty) {
      return;
    }

    NilaiKuliah nilaiKuliah;

    try {
      if (selectedNilaiId != null) {
        nilaiKuliah = NilaiKuliah(
          id: selectedNilaiId!,
          idmahasiswa: int.parse(idMahasiswa),
          idmatakuliah: int.parse(idMatakuliah),
          nilai: double.parse(nilai),
        );
        await _apiService.updateNilai(nilaiKuliah);
      } else {
        nilaiKuliah = NilaiKuliah(
          id: 0,
          idmahasiswa: int.parse(idMahasiswa),
          idmatakuliah: int.parse(idMatakuliah),
          nilai: double.parse(nilai),
        );
        await _apiService.createNilai(nilaiKuliah);
      }
    } catch (e) {
      // Handle error
    }

    _clearTextFieldsAndRefreshData();
  }

  void _clearTextFieldsAndRefreshData() {
    // Clear text fields
    _idMahasiswaController.clear();
    _idMatakuliahController.clear();
    _nilaiController.clear();

    // Reset selectedNilaiId to null
    selectedNilaiId = null;

    // Trigger a refresh of the data
    _refreshData();

    // Trigger a rebuild of the widget tree to reflect changes in the UI
    setState(() {});
  }

  Future<void> _deleteNilai(int nilaiId) async {
    try {
      await _apiService.deleteNilai(nilaiId);
      _refreshData();
    } catch (e) {
      // Handle error
    }
  }

  void _showErrorDialog(String message) {
    // Handle error
  }

  Future<void> _showEditDialog(NilaiKuliah nilai) async {
    _idMahasiswaController.text = nilai.idmahasiswa.toString();
    _idMatakuliahController.text = nilai.idmatakuliah.toString();
    _nilaiController.text = nilai.nilai.toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Nilai'),
        content: Column(
          children: [
            _buildTextFormField(_idMahasiswaController, 'ID Mahasiswa'),
            _buildTextFormField(_idMatakuliahController, 'ID Matakuliah'),
            _buildTextFormField(_nilaiController, 'Nilai'),
          ],
        ),
        actions: [
          _buildTextButton('Cancel', () => Navigator.of(context).pop()),
          _buildTextButton('Update', () async {
            _validateAndSaveNilai();
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Future<void> _validateAndSaveNilai() async {
    String idMahasiswa = _idMahasiswaController.text;
    String idMatakuliah = _idMatakuliahController.text;
    String nilai = _nilaiController.text;

    if (idMahasiswa.isNotEmpty && idMatakuliah.isNotEmpty && nilai.isNotEmpty) {
      if (selectedNilaiId != null) {
        await _updateNilai(idMahasiswa, idMatakuliah, nilai);
      } else {
        await _createNilai(idMahasiswa, idMatakuliah, nilai);
      }

      _clearTextFieldsAndRefreshData();
    }
  }

  Future<void> _updateNilai(
      String idMahasiswa, String idMatakuliah, String nilai) async {
    NilaiKuliah updatedNilai = NilaiKuliah(
      id: selectedNilaiId!,
      idmahasiswa: int.parse(idMahasiswa),
      idmatakuliah: int.parse(idMatakuliah),
      nilai: double.parse(nilai),
    );
    await _apiService.updateNilai(updatedNilai);
  }

  Future<void> _createNilai(
      String idMahasiswa, String idMatakuliah, String nilai) async {
    NilaiKuliah newNilai = NilaiKuliah(
      id: 0,
      idmahasiswa: int.parse(idMahasiswa),
      idmatakuliah: int.parse(idMatakuliah),
      nilai: double.parse(nilai),
    );
    await _apiService.createNilai(newNilai);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextFormField(_idMahasiswaController, 'ID Mahasiswa'),
                  _buildTextFormField(_idMatakuliahController, 'ID Matakuliah'),
                  _buildTextFormField(_nilaiController, 'Nilai'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _createOrUpdateNilai,
                    child: const Text('Create/Update Nilai'),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<NilaiKuliah>>(
              future: _apiService.fetchNilai(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  nilaiList = snapshot.data!;
                  return ListView.builder(
                    itemCount: nilaiList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('ID Mahasiswa: ${nilaiList[index].idmahasiswa}'),
                        subtitle: Text('ID Matakuliah: ${nilaiList[index].idmatakuliah}'),
                        onTap: () async {
                          await _showEditDialog(nilaiList[index]);
                        },
                        onLongPress: () async {
                          await _deleteNilai(nilaiList[index].id);
                          _refreshData();
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _deleteNilai(nilaiList[index].id);
                                _refreshData();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await _showEditDialog(nilaiList[index]);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
