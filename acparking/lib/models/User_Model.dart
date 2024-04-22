// ignore_for_file: file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class User {
  List<UserModel> items = [];

  User();

  User.fromJsonList(jsonList) {
    if (jsonList == null) {
      return;
    } else {
      jsonList.forEach((id, prod) {
        final user = UserModel.fromJson(prod);
        user.id = id;

        items.add(user);
      });
    }
  }
}

class UserModel {
  String? id;
  String? mail;
  String? nameuser;
  String? pass;

  UserModel({
    this.id,
    this.mail,
    this.nameuser,
    this.pass,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
