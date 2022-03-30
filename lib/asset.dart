/* import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Asset extends StatelessWidget {
  const Asset({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    File fichier;
    String path ="images.Minato.jpg";
    void fileExists(String path) async
    {
      var dir = await getApplicationDocumentsDirectory();
      var pathg = dir.path;
      //print(path);

      var file = File("./images.Minato.jpg");
      print(await file.exists());
      //print("${await getApplicationDocumentsDirectory()}/$path");

      //var fichier = await File(path).exists();
    }


    void fileExist(path) async
    {
      var file = File(path);
      print(await file.exists());

      //var fichier = await File(path).exists();
    }

      void getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('assets/$path');

      final file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      fichier = file;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Test"),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
             ,
            width: 130,
            height: 130,
            fit: BoxFit.cover,
          ),
        )
    );
  }
}


 */