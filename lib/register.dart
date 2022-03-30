import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:date_field/date_field.dart';
import 'package:user_managment/user.dart';
import 'package:user_managment/userListScreen.dart';
import 'db.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();
  final genderController = TextEditingController();
  final mailController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();
  final pictureController = TextEditingController();
  final citationController = TextEditingController();
  final birthdayController = TextEditingController();
  DateTime? birthday = DateTime.now();
  String sexe = "Masculin";
  String? picture;
  User? user;
  File? imageFile;
  bool imageError = false;





  @override
  void dispose() {
    lastnameController.dispose();
    firstnameController.dispose();
    genderController.dispose();
    mailController.dispose();
    adressController.dispose();
    phoneController.dispose();
    pictureController.dispose();
    citationController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> _items = [
      {
        'value': 'Masculin',
        'label': 'Masculin',
        'icon': const Icon(Icons.male_outlined, color: Colors.blue),
        'textStyle': const TextStyle(color: Colors.blue),
      },
      {
        'value': 'Féminin',
        'label': 'Féminin',
        'icon': const Icon(Icons.female_outlined, color: Colors.blue),
        'textStyle': const TextStyle(color: Colors.blue),
      }
    ];
    Future pickImage() async {
      try {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);

        if(image == null) return;
        setState(() {
          imageError = false;
        });
        final imageTemp = File(image.path);

        setState(() => imageFile = imageTemp);

/*
        final directory = await getExternalStorageDirectory();
        print('Success');
        try {
          if (directory != null) return File(imageFile!.path).copy('${directory.path}/name.png');
          print('Success');
        }on PlatformException catch(e) {
          print(e);
        }

 */

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
        title: const Text("Ajouter un utilisateur"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imageFile == null ?  const Image(
                                  image: AssetImage('images/user.png'),
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ) : Image.file(
                                  imageFile!,
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          /*CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: imageFile != null ? Image.file(imageFile!) :Image.asset(
                                  "images/user.png",
                                  fit: BoxFit.cover,
                              ),
                            )*/
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 46, right: 12),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            pickImage();
                          },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  "Choisir une image",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),

                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: imageError ? const Text(
                    "Veillez choisir une image",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red)
                ) : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                controller: lastnameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Nom",
                    hintText: "Enter votre nom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le nom est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                controller: firstnameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Prénom",
                    hintText: "Enter votre prénom",
                    icon: Icon(Icons.person, color : Colors.blue, size: 25,)
                ),
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le prénom est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Enter votre numéro de téléphone",
                    icon: Icon(Icons.phone, color : Colors.blue, size: 25,)
                ),
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "Le téléphone est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
            child: TextFormField(
              controller: mailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter votre Email",
                  icon: Icon(Icons.email, color : Colors.blue, size: 25,)
              ),
              validator: (value){
                if(value!.isEmpty)
                {
                  return "L'Email est réquis";
                }
                return null;
              },
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                controller: adressController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    labelText: "Adresse",
                    hintText: "Enter votre Adresse",
                    icon: Icon(Icons.add_location, color : Colors.blue, size: 25,)
                ),
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "L'adresse est réquis";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: TextFormField(
                controller: citationController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: "Citation",
                    hintText: "Enter votre Citation",
                    icon: Icon(Icons.email, color : Colors.blue, size: 25,),

                ),
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "La citation est réquise";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: SelectFormField(
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: sexe,
                icon: const Icon(Icons.person),
                labelText: 'Sexe',
                items: _items,
                onChanged: (val){
                  setState(() {
                    sexe = val;
                  });
                  //print(sexe);
                },
                onSaved: (val) => print(val),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
              child: DateTimeFormField(
                initialValue: DateTime.now(),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Date de Naissance',

                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                firstDate: DateTime(DateTime.now().year - 10),
                lastDate: DateTime.now(),
                validator: (e) => (e) == null
                    ? 'Entrer votre date de Naissance'
                    : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    birthday = value;
                  });
                  //print(value);
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {



                    if(imageFile == null) {
                      setState(() {
                        imageError = true;
                      });
                    }else
                     {
                      setState(() {
                        picture = imageFile?.path;
                      });
                    }
                    //print(picture);

                    if(formKey.currentState!.validate())
                      {
                        String date = "${birthday?.year.toString()}-${birthday?.month.toString().padLeft(2, '0')}-${birthday?.day.toString().padLeft(2, '0')}";

                        user = User(
                          null, // creer une methode qui verifie si le nombre generer existe deja dans la database
                          0,
                          firstnameController.value.text, // exist
                          lastnameController.value.text,// exist
                          date,// not exist birthdayController.value.text
                          adressController.value.text,// exist
                          phoneController.value.text,// exist
                          mailController.value.text,// exist
                          sexe,// exist
                          picture!,// not exist
                          citationController.value.text,// exist
                        );
                         //stdout.writeln("Les données ont été souumise");
                        //print(user.toString());
                          Db.instance.insertUser(user!);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>  const UserListScreen()
                          )
                        );
                        //Navigator.pop(context);
                      }
                  }, child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("S'inscrire", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


