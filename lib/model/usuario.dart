import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Usuario {
  String api_key;
  String email;
  String password;

  Usuario(this.api_key, this.email, this.password);

  static Future<String> valida(String e, String c) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.http(
              '10.0.2.2:8000', '/api/login', {'username': e, 'password': c}))
          .timeout(Duration(seconds: 5));

      print("RESPUESTA " + respuesta.body);
      return respuesta.body;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return jsonEncode({'respuesta': 'Error de conexión'});
    }
  }
}
