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
        primarySwatch: Colors.yellow,
      ),
      home: MainMenu(),
      routes: {
        '/mahasiswa': (context) => mahasiswaApp(),

        '/matakuliah': (context) => MataKuliahApp(),
        '/nilai': (context) => NilaiKuliahApp(),
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
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih Menu :',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //mahasiswa
                ElevatedButton(
                  onPressed : () {
                    Navigator.pushNamed(context, '/mahasiswa');
                  },
                  child: Text('Mahasiswa'),
                ),
                SizedBox(width: 20),

                //matakuliah
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/matakuliah');
                  },
                  child: Text('Matakuliah'),
                ),
                SizedBox(width: 20),

                //nilaikuliah
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nilai');
                  },
                  child: Text('NilaiKuliah'),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}//hahahaha error kan

