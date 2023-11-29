import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController txtConNombre = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String? _uploadedFileURL;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = _image!.path;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images/" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image!);
    await uploadTask.whenComplete(() async {
      print('File Uploaded');
      _uploadedFileURL = await ref.getDownloadURL();
      print(_uploadedFileURL);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File Uploaded')));
    });
  }

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(
      height: 20,
    );

    final txtNomUser = TextField(
      decoration: const InputDecoration(
          label: Text('Nombre:'), border: OutlineInputBorder()),
      controller: txtConNombre,
    );

    final txtEmailUser = TextField(
      decoration: const InputDecoration(
          label: Text('Email:'), border: OutlineInputBorder(), enabled: false),
      controller: txtConEmail,
    );

    final btnFoto = FloatingActionButton.extended(
      icon: const Icon(Icons.image),
      label: const Text('Seleccionar foto de perfil'),
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      onPressed: () {
        getImage();
      },
    );

    final btnSave = ElevatedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text('Guardar foto de perfil'),
      onPressed: () {
        uploadImageToFirebase(context);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              space,
              txtNomUser,
              space,
              txtEmailUser,
              space,
              btnFoto,
              space,
              btnSave,
              _uploadedFileURL == null
                  ? Text('No image uploaded.')
                  : Image.network(_uploadedFileURL!),
            ],
          ),
        ),
      ),
    );
  }
}
