// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/Usuario.dart';

class UsuarioProvider {
  final String _endpoint = "https://dbpark-767b1-default-rtdb.firebaseio.com";

  Future<bool> crearusuario(Usuario user) async {
    try {
      final url = '$_endpoint/parking/user/iduser.json';
      final resp = await http.post(
        Uri.parse(url),
        body: usuarioToJson(user),
      );

      if (resp.statusCode == 200) {
        final decodeData = jsonDecode(resp.body);
        if (kDebugMode) {
          print(decodeData);
        }
        return true;
      } else {
        throw Exception("Ocurrio Algo ${resp.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
      //throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<List<Usuario>> getUser() async {
    try {
      final url = '$_endpoint/parking/user/iduser.json';
      final resp = await http.get(Uri.parse(url));

      if (resp.statusCode == 200) {
        final jsonData = jsonDecode(resp.body);

        if (jsonData != null && jsonData is Map<String, dynamic>) {
          List<Usuario> usuarios = [];

          jsonData.forEach((key, userJson) {
            if (userJson is Map<String, dynamic>) {
              final user = Usuario.fromJson(userJson);
              user.id = key;
              usuarios.add(user);
            }
          });

          return usuarios;
        } else {
          if (kDebugMode) {
            print("La respuesta de la API no es un Map válido.");
          }
        }
      } else {
        throw Exception("Ocurrio Algo ${resp.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error al obtener usuarios: $e");
      }
    }

    return []; // Devuelve una lista vacía en caso de error o excepción.
  }

  Future<bool> updateusuario(Usuario user) async {
    try {
      final url = '$_endpoint/parking/user/iduser/${user.id}.json';
      final resp = await http.post(
        Uri.parse(url),
        body: usuarioToJson(user),
      );

      if (resp.statusCode == 200) {
        final decodeData = jsonDecode(resp.body);
        if (kDebugMode) {
          print(decodeData);
        }
        return true;
      } else {
        throw Exception("Ocurrio Algo ${resp.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
      //throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<int> borrarUser(String id) async {
    try {
      final url = '$_endpoint/parking/user/iduser/$id.json';
      final resp = await http.delete(Uri.parse(url));

      if (resp.statusCode == 200) {
        final decodeData = jsonDecode(resp.body);
        if (kDebugMode) {
          print(decodeData);
        }
        return 1;
      } else {
        throw Exception("Ocurrio Algo ${resp.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0;
      //throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }
}
