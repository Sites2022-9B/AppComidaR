import 'package:flutter/material.dart';
import 'package:practica_1/ui/menu_opciones.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class Imagen extends StatefulWidget {
  // const MainScreen({Key? key}) : super(key: key);

  @override
  _ImagenState createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  // File? imagen;
  dynamic imagen;
  final picker = ImagePicker();

  Future selImagen(op) async {
    dynamic pickedFile;

    if (op == 1) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print('no hay foto seleccionada');
      }
    });
    Navigator.of(context).pop();
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selImagen(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.image,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selImagen(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tomar foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Foto'),
      ),
      drawer: menuOpciones(context),
      backgroundColor: Color.fromARGB(255, 5, 29, 72),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    opciones(context);
                  },
                  child: Text('Selecciona una imagen'),
                ),
                SizedBox(
                  height: 30,
                ),
                imagen == null ? Center() : Image.file(imagen)
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.refresh_rounded),
      //   onPressed: pickImage,
      // ),
    );
  }
}
