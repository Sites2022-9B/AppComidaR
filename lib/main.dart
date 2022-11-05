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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 50, top: 110),
            child: const Text(
              "Bienvenidos a \n Comida Fast",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  controller: _txtController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Ingresar correo',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: TextField(
                    controller: _passController,
                    obscureText: _ocultarPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: _iconoOjo,
                    onPressed: () {
                      setState(() {
                        _ocultarPassword = !_ocultarPassword;
                        _iconoOjo = _ocultarPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          String r = await Usuario.valida(
                              _txtController.value.text,
                              _passController.value.text);
                          print(_txtController.value.text);
                          print(_passController.value.text);
                          print(r);
                          var json = jsonDecode(r);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(json['respuesta'])));

                          if (json['respuesta'] == 'Bienvenido') {
                            Datos.registraToken(json['token']);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Welcome(title: widget.title);
                                },
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Recuperar \nContraseña',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
