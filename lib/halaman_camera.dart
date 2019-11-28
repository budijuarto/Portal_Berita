import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class HalamanCamera extends StatefulWidget {
  @override
  _HalamanCameraState createState() => _HalamanCameraState();
}

class _HalamanCameraState extends State<HalamanCamera> {
  File fileImage;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      fileImage = image;
    });
   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HalamanShareGambar(
                            imagePath: fileImage.path,
                          )));
  }

  Future getImageFromGalery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = image;
    });
  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HalamanShareGambar(
                            imagePath: fileImage.path,
                          )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("camera"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HalamanShareGambar(
                            imagePath: fileImage.path,
                          )));
            },
          ),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
             tampilPilihan();
             },
          )
        ],
      ),
      
    );
  }
  tampilPilihan() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Take a photo",style: TextStyle(color: Colors.blue),),
                    onTap: () {
                      getImageFromCamera();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: Text("Open galery",style: TextStyle(color: Colors.blue)),
                    onTap: () {
                      getImageFromGalery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class HalamanShareGambar extends StatefulWidget {
  var imagePath;
  HalamanShareGambar({Key key, this.imagePath}) : super(key: key);
  @override
  _HalamanShareGambarState createState() => _HalamanShareGambarState();
}

class _HalamanShareGambarState extends State<HalamanShareGambar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Images"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: RaisedButton(
                  onPressed: () {
                    getByteFromFile().then((byte) {
                      Share.file(
                          "Share Image via :",
                          path.basename(widget.imagePath),
                          byte.buffer.asUint8List(),
                          "image/png");
                    });
                  },
                  child: Text("Share"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ByteData> getByteFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}
