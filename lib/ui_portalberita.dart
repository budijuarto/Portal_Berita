import 'package:aplikasi_portal_berita/model_berita.dart';
import 'package:flutter/material.dart';

import 'halaman_portabberita.dart';

class UIPortalBerita {
  uiListBerita(BuildContext context, Article listBerita) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBerita(
                      article: listBerita,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 7,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  listBerita?.urlToImage ??
                      "https://cdn.pixabay.com/photo/2016/05/13/13/33/newspaper-1389980_960_720.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  listBerita?.title ?? 'Tidak ada Title',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        listBerita?.author ?? "BKKPN",
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        listBerita?.publishedAt.toString() ?? 'tidak ada tgl',
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      
    );
  }

  uiDetailBerita(BuildContext context, Article article) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InkWell(
            child: Image.network(article.urlToImage,fit: BoxFit.fill,),
          ),
          Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        article?.author ?? "BKKPN",
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        article?.publishedAt.toString() ?? 'tidak ada tgl',
                        style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
             Text(article?.content ?? "tidak ada content")
        ],
      ),
    );
  }
}
