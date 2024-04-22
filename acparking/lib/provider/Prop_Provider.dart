// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/Prop_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PropProvider {
  final String _endpoint =
      "https://dbapark-ad140-default-rtdb.firebaseio.com/parking";

  Future<bool> crearprop(PropModel prop) async {
    try {
      final url = '$_endpoint/Propietarios/idpropietario.json';
      final resp = await http.post(
        Uri.parse(url),
        body: propModelToJson(prop),
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

  Future<List<PropModel>> getprop() async {
    final url = '$_endpoint/Propietarios/idpropietario.json';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final jsonData = jsonDecode(body);
      final prop = Propi.fromJsonList(jsonData);
      return prop.items;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<bool> actuprop(PropModel prop) async {
    try {
      final url = '$_endpoint/Propietarios/idpropietario/${prop.id}.json';
      final resp = await http.put(
        Uri.parse(url),
        body: propModelToJson(prop),
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

  Future<int> borrarprop(String id) async {
    try {
      final url = '$_endpoint/Propietarios/idpropietario/$id.json';
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
