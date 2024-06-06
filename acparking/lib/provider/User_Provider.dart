// ignore_for_file: file_names

import 'dart:convert';
import 'package:acparking/models/User_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _endpoint = "https://cerjattin.pythonanywhere.com/api";

  Future<bool> crearuser(UserModel user) async {
    try {
      final url = '$_endpoint/addUser';
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
    final url = '$_endpoint/alluser';
    final resp = await http.get(Uri.parse(url));

    if (resp.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(resp.body);
      List<UserModel> users = [];
      print("object${users.length}");
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

  Future<int> borraruser(String id) async {
    try {
      final url = '$_endpoint/DeleteUsers';
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
