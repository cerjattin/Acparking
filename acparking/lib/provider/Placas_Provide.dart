// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/Placas_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PlacasProvider {
  final String _endpoint =
      "https://dbapark-ad140-default-rtdb.firebaseio.com/parking";

  Future<bool> crearplaca(PlacasModel placas) async {
    try {
      final url = '$_endpoint/Placas/idplaca.json';
      final resp = await http.post(
        Uri.parse(url),
        body: placasModelToJson(placas),
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

  Future<List<PlacasModel>> getplacas() async {
    final url = '$_endpoint/Placas/idplaca.json';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final jsonData = jsonDecode(body);
      print(jsonData);
      final product = Placa.fromJsonList(jsonData);

      return product.items;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<bool> actuplaca(String id, PlacasModel placas) async {
    try {
      final url = '$_endpoint/Placas/idplaca/$id.json';
      final resp = await http.put(
        Uri.parse(url),
        body: placasModelToJson(placas),
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

  Future<int> borrarplacas(String id) async {
    try {
      final url = '$_endpoint/Placas/idplaca/$id.json';
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
