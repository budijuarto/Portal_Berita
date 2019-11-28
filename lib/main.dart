import 'package:aplikasi_portal_berita/halaman_portabberita.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter API",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HalamanPortalBerita(),
    );
  }
}

class HalamanMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Column(
        children: <Widget>[
          Container(width:double.infinity,
          child: RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HalamanPortalBerita()));
          },),)
        ],
      ),
    );
  }
}
