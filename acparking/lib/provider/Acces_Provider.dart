// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/Acces_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AccesProvider {
  final String _endpoint =
      "https://dbapark-ad140-default-rtdb.firebaseio.com/parking";

  Future<bool> crearaceso(AccessModel access) async {
    try {
      final url = '$_endpoint/Accespark/idplaca.json';
      final resp = await http.post(
        Uri.parse(url),
        body: accessModelToJson(access),
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
    }
  }

  Future<List<AccessModel>> getaccess() async {
    final url = '$_endpoint/Accespark/idplaca.json';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final jsonData = jsonDecode(body);
      final access = Access.fromJsonList(jsonData);
      return access.items;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<bool> actuacces(AccessModel access) async {
    try {
      final url = '$_endpoint/Accespark/idplaca/${access.placa}';
      final resp = await http.put(
        Uri.parse(url),
        body: accessModelToJson(access),
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
    }
  }

  Future<int> borraracces(String placa) async {
    try {
      final url = '$_endpoint/Accespark/idplaca/$placa.json';
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
    }
  }
}
