import 'dart:convert';

import 'package:practica_1/model/db.dart';
import 'package:practica_1/model/usuario.dart';
import 'package:practica_1/ui/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'COMIDAS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _ocultarPassword = true;
  Icon _iconoOjo = Icon(Icons.visibility_off);
  TextEditingController _txtController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _txtController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    label: Text('Email:'),
                    helperText: 'Tu dirección de correo'),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: TextField(
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  obscureText: _ocultarPassword,
                  decoration: InputDecoration(
                      label: Text('Contraseña:'),
                      helperText: 'Tu contraseña de usuario'),
                ),
                trailing: IconButton(
                  icon: _iconoOjo,
                  onPressed: () {
                    setState(() {
                      _ocultarPassword = !_ocultarPassword;
                      _iconoOjo = _ocultarPassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      String r = await Usuario.valida(_txtController.value.text,
                          _passController.value.text);
                      print(r);
                      var json = jsonDecode(r);

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(json['respuesta'])));

                      if (json['respuesta'] == 'Bienvenido') {
                        Datos.registraToken(json['token']);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Welcome(title: widget.title);
                        }));
                      }
                    },
                    child: Text(
                      'Ingresar',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
