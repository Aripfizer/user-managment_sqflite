import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class Testimage extends StatelessWidget {
  const Testimage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   /* void getImage() async
    {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      if(result != null) {
        File file = File(result.files.single.path);
        print(file.name);
        print(file.bytes);
        print(file.size);
        print(file.extension);
        print(file.path);
        /*
        ONE IMAGE
         FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result == null) return;  // if user don't pick any thing then do nothing just return.
          PlatformFile file = result!.files.first;


          void viewFile(PlatformFile file) {
            OpenFile.open(file.path);
            }

         */

      } else {
        // User canceled the picker
      }
    }


    */

    
    void openFile(PlatformFile file) {
      OpenFile.open(file.path);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test image"),
        ),
        body: ElevatedButton(
          child: const Text("Choisir une image"),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles();

            if (result != null) {
              //File file = File(result!.files.single.path);
              final file  = result.files.first;
              //openFile(file);
              print(file.name);
              print(file.bytes);
              print(file.size);
              print(file.extension);
              print(file.path);

              openFile(file);
              final newFile = await saveFile(file);

              print(newFile);
              //print("\n\n\n From the path :  ${file.path}");
              //print("\n To the path :  ${newFile.path}");

            } else {
              return;
            }

          },
        ),
    );
  }
}
Future<File> saveFile(PlatformFile file) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final newFile = File('$appStorage/images/${file.name}');
  return File(file.path!).copy(newFile.path);
}

