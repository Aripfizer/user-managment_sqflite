import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Essaie extends StatefulWidget {
  const Essaie({Key? key}) : super(key: key);

  @override
  State<Essaie> createState() => _EssaieState();
}

class _EssaieState extends State<Essaie> {
  File? imageFile;
  String IMG_KEY = 'IMAGE_KEY';

  @override
  Widget build(BuildContext context) {


    Future<bool> saveImage(String value) async{
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.setString(IMG_KEY, value);
    }

    Future<String?> getImageFromPreferencies() async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString(IMG_KEY);
    }

    String base64String(Uint8List data) {
      return base64Encode(data);
    }

    Image imageFromBase64String(String data) {
      return Image.memory(
        base64Decode(data),
        fit: BoxFit.fill,
      );
    }

    Future pickImage() async {
      try {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);

        if(image == null) return;

        final imageTemp = File(image.path);

        setState(() => imageFile = imageTemp);
        /*
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('test_image', imageFile!.path);

         */



        final directory = await getExternalStorageDirectory();
        print('Success');
        try {
          if (directory != null) return File(imageFile!.path).copy('${directory.path}/name.png');
          print('Success');
        }on PlatformException catch(e) {
          print(e);
        }

        /*
          final String appStorage = await getApplicationDocumentsDirectory().path;
          final newFile = File('$appStorage/images/${basename(imageFile!.path)}');
          return File(imageFile!.path).copy(newFile.path);

         */

      } on PlatformException catch(e) {
        print('Failed to pick imageFile: $e');
      }
    }




    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage();
                  }
              ),
              SizedBox(height: 20,),
              imageFile != null ? Image.file(imageFile!): Text("No imageFile selected")
            ],
          ),

        ),

    );
  }
}
