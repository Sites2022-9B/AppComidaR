import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Usuario {
  String api_key;
  String email;
  String password;
  static String direccion = '192.168.43.2:5000';

  Usuario(this.api_key, this.email, this.password);

  static Future<String> valida(String e, String c) async {
    try {
      final respuesta = await http.Client()
          .get(
              Uri.http(direccion, '/api/login', {'username': e, 'password': c}))
          .timeout(Duration(seconds: 8));

      print("RESPUESTA " + respuesta.body);
      return respuesta.body;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return jsonEncode({'respuesta': 'Error de conexión'});
    }
  }

  static Future<bool> validaToken(String token) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.http(direccion, 'api/validatoken', {'api_token': token}))
          .timeout(Duration(seconds: 5));

      print("Valida token resp " + respuesta.body);
      return respuesta.body.toString() == 'VALIDO';
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return false;
    }
  }
}
