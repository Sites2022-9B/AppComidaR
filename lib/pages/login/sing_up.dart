import 'package:flutter/material.dart';

class SingUpComida extends StatefulWidget {
  const SingUpComida({Key? key}) : super(key: key);

  @override
  State<SingUpComida> createState() => _SingUpComidaState();
}

class _SingUpComidaState extends State<SingUpComida> {
  bool _ocultarPassword = true;
  Icon _iconoOjo = const Icon(Icons.visibility_off);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Crear\nCuenta",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.27),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    labelText: 'Nombre',
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    labelText: 'Correo',
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: TextField(
                    obscureText: _ocultarPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'Contraseña',
                      hintStyle: const TextStyle(color: Colors.black),
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
                  height: 30,
                ),
                ListTile(
                  title: TextField(
                    obscureText: _ocultarPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'Repetir contraseña',
                      hintStyle: const TextStyle(color: Colors.black),
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
                        'Registrarse',
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
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
