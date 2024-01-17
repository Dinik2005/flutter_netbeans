import 'dart:convert';
import 'package:flutter_application_crud/nilaikuliah/nilaikuliah.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.238:9003/api/v1/nilai';

  //memanggil data bukan si dinik
  Future<List<NilaiKuliah>> getNilaiKuliah() async {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Iterable<dynamic> data = json.decode(response.body);
        return data.map((json) => NilaiKuliah.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load nilai. Status Code: ${response.statusCode}');
      }
  }

  Future<NilaiKuliah> getNilaiKuliahById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return NilaiKuliah.fromJson(data);
    } else {
      throw Exception('Failed to load mata kuliah by ID');
    }
  }

  Future<NilaiKuliah> createNilaiKuliah(NilaiKuliah nilaiKuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilaiKuliah.toJson()),
    );
    if(response.statusCode == 200) {
      return NilaiKuliah(
          id: 0,
          idmahasiswa: nilaiKuliah.idmahasiswa,
          idmatakuliah: nilaiKuliah.idmatakuliah,
          nilai: nilaiKuliah.nilai);
    } else {
      throw Exception('Failed to create mata kuliah');
    }
  }

//update

  Future<NilaiKuliah> updateNilaiKuliah(NilaiKuliah nilaiKuliah) async {
    final response = await http.post(
      Uri.parse('$baseUrl/${nilaiKuliah.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id' : nilaiKuliah.id,
          'idmahasiswa' : nilaiKuliah.idmahasiswa,
          'idmatakuliah' : nilaiKuliah.idmatakuliah,
          'nilai' : nilaiKuliah.nilai,
        }),
    );
    print("Response from server: ${response.body}");
    print(nilaiKuliah.idmahasiswa);
    print(nilaiKuliah.idmatakuliah);
    print(nilaiKuliah.nilai);

    if (response.statusCode == 200) {
      print("Update successsfull");
      return NilaiKuliah.fromJson(json.decode(response.body));
    } else {
      print("Update Failed");
      throw Exception('Failed to update mata kuliah');
    }
  }

  //delete

  Future<void> deleteNilaiKuliah(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete mata kuliah');
    }
  }
}
