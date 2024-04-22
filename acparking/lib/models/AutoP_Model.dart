// ignore_for_file: file_names

import 'dart:convert';

AutopModel autopModelFromJson(String str) =>
    AutopModel.fromJson(json.decode(str));

String autopModelToJson(AutopModel data) => json.encode(data.toJson());

class Autop {
  List<AutopModel> items = [];

  Autop();

  Autop.fromJsonList(jsonList) {
    if (jsonList == null) {
      return;
    } else {
      jsonList.forEach((id, prod) {
        final autop = AutopModel.fromJson(prod);
        autop.idautorizado = id;

        items.add(autop);
      });
    }
  }
}

class AutopModel {
  String? document;
  String? idautorizado;
  String? nameAutorizado;

  AutopModel({
    this.document,
    this.idautorizado,
    this.nameAutorizado,
  });

  factory AutopModel.fromJson(Map<String, dynamic> json) => AutopModel(
        document: json["document"],
        idautorizado: json["idautorizado"],
        nameAutorizado: json["name_autorizado"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "idautorizado": idautorizado,
        "name_autorizado": nameAutorizado,
      };
}
