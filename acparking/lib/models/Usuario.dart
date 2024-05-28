// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class User {
  List<Usuario> items = [];

  User();

  User.fromJsonList(jsonList) {
    if (jsonList == null) {
      return;
    } else {
      jsonList.forEach((id, prod) {
        final user = Usuario.fromJson(prod);
        user.id = id;
        items.add(user);
      });
    }
  }
}

class Usuario {
  String? id;
  String? mail;
  String? nameuser;
  String? pass;

  Usuario({
    required this.id,
    required this.mail,
    required this.nameuser,
    required this.pass,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        mail: json["mail"],
        nameuser: json["nameuser"],
        pass: json["pass"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mail": mail,
        "nameuser": nameuser,
        "pass": pass,
      };
}
