import 'dart:convert';
import 'package:flutter_application_crud/nilaikuliah/nilaikuliah.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.100.168:9003/api/v1/nilai';

  Future<List<NilaiKuliah>> fetchNilai() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => NilaiKuliah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load nilai');
    }
  }

  Future<NilaiKuliah> createNilai(NilaiKuliah nilaikuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilaikuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return NilaiKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create nilai');
    }
  }

  Future<NilaiKuliah> updateNilai(NilaiKuliah nilaikuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${nilaikuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilaikuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return NilaiKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update nilai');
    }
  }

  Future<void> deleteNilai(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete nilai');
    }
  }
}
