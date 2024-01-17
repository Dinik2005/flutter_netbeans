import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_crud/matakuliah/matakuliah.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.238:9002/api/v1/matakuliah';

//memanggil data bukan fakta coplak
  Future<List<MataKuliah>> getMataKuliah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => MataKuliah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matakuliah');
    }
  }

  Future<MataKuliah> getMataKuliahById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return MataKuliah.fromJson(data);
    } else {
      throw Exception('Failed to load mata kuliah by ID');
    }
  }
//create
  Future<MataKuliah> createMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mataKuliah.toJson()),
    );

    if (response.statusCode == 200) {
      //return MataKuliah.fromJson(json.decode(response.body));
      return MataKuliah(
          id: 0,
          kode: mataKuliah.kode,
          nama: mataKuliah.nama,
          sks: mataKuliah.sks);
    } else {
      throw Exception('Failed to create mata kuliah');
    }
  }

  //update
  Future<MataKuliah> updateMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.post(
      Uri.parse('$baseUrl/${mataKuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode
        ({
        'id': mataKuliah.id,
        'kode' :mataKuliah.kode,
        'nama' :mataKuliah.nama,
        'sks' :mataKuliah.sks,
      }),
    );
    print("Response from server: ${response.body}");
    print(mataKuliah.kode);
    print(mataKuliah.nama);
    print(mataKuliah.sks);

    if (response.statusCode == 200) {
      print("Update successsfull");
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      print("Update Failed");
      throw Exception('Failed to update mata kuliah');
    }
  }

  //delete
  Future<void> deleteMataKuliah(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete mata kuliah');
    }
  }
}
