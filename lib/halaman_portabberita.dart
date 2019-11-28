import 'dart:convert';
import 'package:aplikasi_portal_berita/ui_portalberita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'model_berita.dart';

class HalamanPortalBerita extends StatefulWidget {
  HalamanPortalBerita({Key key}) : super(key: key);

  _HalamanPortalBeritaState createState() => _HalamanPortalBeritaState();
}

class _HalamanPortalBeritaState extends State<HalamanPortalBerita> {
  var loading = true;
  List listBerita = null;
  var uiPortalBerita = UIPortalBerita();
  Future getDataBerita() async {
    String baseURL =
        "https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=f1d161e3bfa044d0be4661253de8c9ac";
    var res = await http.get(Uri.encodeFull(baseURL));
    if (res.statusCode == 200) {
      Toast.show("SUCCESS", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      var data = json.decode(res.body);
      var responseBerita = data['articles'] as List;
      setState(() {
        loading = false;
        listBerita = responseBerita
            .map<Article>((json) => Article.fromJson(json))
            .toList();
      });
    } else {
      Toast.show("GAGAL", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      setState(() {
        loading = false;
      });
    }
    return listBerita;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Portal Berita"),
        ),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listBerita.length,
                itemBuilder: (BuildContext context, int index) {
                  return uiPortalBerita.uiListBerita(
                      context, listBerita[index]);
                },
              ));
  }
}

class DetailBerita extends StatelessWidget {
  Article article;
  var uiDetailBerita = UIPortalBerita();
  DetailBerita({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Berita"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HalamanWeb(
                            article: article,
                          )));
            },
          )
        ],
      ),
      body: uiDetailBerita.uiDetailBerita(context, article),
    );
  }
}

class HalamanWeb extends StatelessWidget {
  Article article;

  HalamanWeb({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: article.url,
    );
  }
}
