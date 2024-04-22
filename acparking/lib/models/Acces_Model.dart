// ignore_for_file: file_names

import 'dart:convert';

AccessModel accessFromJson(String str) =>
    AccessModel.fromJson(json.decode(str));

String accessModelToJson(AccessModel data) => json.encode(data.toJson());

class Access {
  List<AccessModel> items = [];

  Access();

  Access.fromJsonList(jsonList) {
    if (jsonList == null) {
      return;
    } else {
      jsonList.forEach((placa, prod) {
        final access = AccessModel.fromJson(prod);
        access.placa = placa;

        items.add(access);
      });
    }
  }
}

class AccessModel {
  String? placa;
  String? hrInp;
  String? hrOut;

  AccessModel({
    this.placa,
    this.hrInp,
    this.hrOut,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) => AccessModel(
        placa: json["Placa"],
        hrInp: json["hr_inp"],
        hrOut: json["hr_out"],
      );

  Map<String, dynamic> toJson() => {
        "Placa": placa,
        "hr_inp": hrInp,
        "hr_out": hrOut,
      };
}
