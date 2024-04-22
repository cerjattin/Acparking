// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/User_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _endpoint =
      "https://dbapark-ad140-default-rtdb.firebaseio.com/parking";

  Future<bool> crearuser(UserModel user) async {
    try {
      final url = '$_endpoint/user/iduser.json';
      final resp = await http.post(
        Uri.parse(url),
        body: userModelToJson(user),
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

  Future<List<UserModel>> getuser() async {
    final url = '$_endpoint/user.json';
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(resp.body);
      List<UserModel> users = [];
      jsonData.forEach((key, value) {
        if (key != "iduser") {
          // Ignorar el placeholder de iduser
          users.add(UserModel.fromJson(value)..id = key);
        }
      });
      return users;
    } else {
      throw Exception("Ocurrio Algo ${resp.statusCode}");
    }
  }

  Future<bool> actuuser(UserModel user) async {
    try {
      final url = '$_endpoint/user/iduser/${user.id}.json';
      final resp = await http.put(
        Uri.parse(url),
        body: userModelToJson(user),
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

  Future<int> borraruser(String id) async {
    try {
      final url = '$_endpoint/user/iduser/$id.json';
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
