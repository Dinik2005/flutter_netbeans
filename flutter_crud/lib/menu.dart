import 'package:flutter/material.dart';
import 'package:flutter_application_crud/main.dart';
import 'package:flutter_application_crud/nilaikuliah/mainnilaikuliah.dart';
import 'package:flutter_application_crud/matakuliah/mainmatakuliah.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Data',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainMenu(),
      routes: {
        '/mahasiswa': (context) => mahasiswaApp (),
        '/nilai': (context) => NilaiPage(),
        '/matakuliah': (context) => MataKuliahApp(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Menu'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pilih Menu:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mahasiswa');
                  },
                  child: Text('Mahasiswa'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nilai');
                  },
                  child: Text('NilaiKuliah'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/matakuliah');
                  },
                  child: Text('Matakuliah'),
                ),
              ],
            ),
            ),
        );
    }
}
