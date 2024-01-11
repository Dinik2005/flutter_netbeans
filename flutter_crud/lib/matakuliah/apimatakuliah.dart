import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_crud/matakuliah/matakuliah.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.100.168:9002/api/v1/matakuliah';

  Future<List<MataKuliah>> getMataKuliah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<MataKuliah> mataKuliahList = data.map((json) => MataKuliah.fromJson(json)).toList();
      return mataKuliahList;
    } else {
      throw Exception('Failed to load mata kuliah');
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

  Future<MataKuliah> createMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mataKuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create mata kuliah');
    }
  }

  Future<MataKuliah> updateMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${mataKuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mataKuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update mata kuliah');
    }
  }

  Future<void> deleteMataKuliah(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete mata kuliah');
    }
  }
}
