import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class Platillo {
  int id;
  String nombre;
  String descripcion;
  double precio;
  String categoria;
  String status;

  Platillo(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.categoria,
      required this.status});

  static Platillo fromJSON(Map<String, dynamic> datos) {
    return Platillo(
        id: datos['id'],
        nombre: datos['nombre'],
        descripcion: datos['descripcion'],
        precio: datos['precio'],
        categoria: datos['categoria'],
        status: datos['status']);
  }

  static Future<List<Platillo>> leeTodos(String token, String busq,
      String precmin, String precmax, String cat) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.http('192.168.43.145:5000', '/api/platillosres', {
            'rest_id': '1',
            'busq': busq,
            'vmin': precmin,
            'vmax': precmax,
            'cat': cat
          }))
          .timeout(Duration(seconds: 5));

      // print("RESPUESTA " + respuesta.body);
      String json = respuesta.body.toString();
      List<dynamic> respuestaJSON = jsonDecode(json);
      List<Map<String, dynamic>> platillosJSON =
          respuestaJSON.cast<Map<String, dynamic>>();
      List<Platillo> platillos = List.generate(platillosJSON.length, (index) {
        return fromJSON(platillosJSON[index]);
      });

      return platillos;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return [];
    }
  }

  Future<bool> registra(String token) async {
    try {
      final respuesta = await http.Client()
          .post(Uri.http('192.168.43.145:5000', '/api/res/platillos/add'),
              body: jsonEncode(<String, String>{
                'api_token': token,
                'nombre': this.nombre,
                'descr': this.descripcion,
                'precio': this.precio.toString(),
                'cat': this.categoria,
              }))
          .timeout(Duration(seconds: 5));

      print("RESPUESTA " + respuesta.body);

      return respuesta.body == 'OK';
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return false;
    }
  }
}

class PrecioMax {
  double preciomax;

  PrecioMax({required this.preciomax});

  static PrecioMax fromJSON(Map<String, dynamic> datos) {
    return PrecioMax(preciomax: datos['precio']);
  }

  static Future<List<PrecioMax>> leeMax(String id) async {
    try {
      final valMax = await http.Client()
          .get(Uri.http('192.168.43.145:5000', '/api/res/platillos/preciomax',
              {'rest_id': '1'}))
          .timeout(Duration(seconds: 5));

      print("VALOR MAXIMO " + valMax.body);

      String json = valMax.body.toString();
      List<dynamic> valJSON = jsonDecode(json);
      List<Map<String, dynamic>> maxJSON = valJSON.cast<Map<String, dynamic>>();
      List<PrecioMax> precmax = List.generate(maxJSON.length, (index) {
        return fromJSON(maxJSON[index]);
      });
      return precmax;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return [];
    }
  }
}
