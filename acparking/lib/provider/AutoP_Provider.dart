// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/AutoP_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AutopProvider {
  final String _endpoint =
      "https://dbapark-ad140-default-rtdb.firebaseio.com/parking";

  Future<bool> crearautoplaca(AutopModel autop) async {
    try {
      final url = '$_endpoint/Placas/idplaca.json';
      final resp = await http.post(
        Uri.parse(url),
        body: autopModelToJson(autop),
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

  Future<List<AutopModel>> getautop() async {
    final url = '$_endpoint/Placas/idplaca/placa_autor.json';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final jsonData = jsonDecode(body);
      final autop = Autop.fromJsonList(jsonData);
      return autop.items;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<bool> actuautop(AutopModel autop) async {
    try {
      final url =
          '$_endpoint/Placas/idplaca/placa_autor/${autop.idautorizado}.json';
      final resp = await http.put(
        Uri.parse(url),
        body: autopModelToJson(autop),
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

  Future<int> borrarautop(String idautorizado) async {
    try {
      final url = '$_endpoint/Placas/idplaca/placa_autor/$idautorizado.json';
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
