// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

PlacasModel placasModelFromJson(String str) =>
    PlacasModel.fromJson(json.decode(str));

String placasModelToJson(PlacasModel data) => json.encode(data.toJson());

class Placa {
  List<PlacasModel> items = [];

  Placa();

  Placa.fromJsonList(jsonList) {
    if (jsonList == null) {
      return;
    } else {
      print(jsonList);
      jsonList.forEach((id, prod) {
        final placa = PlacasModel.fromJson(prod);
        placa.placut = id;
        items.add(placa);
      });
    }
  }
}

class PlacasModel {
  String? document;
  String? nameAutorizado;
  String? saldo;
  String? estado;
  String? id;
  String? date_begin;
  String? date_end;
  String? placut;
  String? placpr;
  String? nameResp;

  PlacasModel({
    this.saldo,
    this.estado,
    this.id,
    this.date_begin,
    this.date_end,
    this.placut,
    this.placpr,
    this.document,
    this.nameAutorizado,
    this.nameResp,
  });

  factory PlacasModel.fromJson(Map<String, dynamic> json) => PlacasModel(
      saldo: json["Saldo"],
      estado: json["estado"],
      id: json["id"],
      date_begin: json["date_begin"],
      date_end: json["date_end"],
      placut: json["Placaaut"],
      placpr: json["Placapr"],
      document: json["document"],
      nameAutorizado: json["name_autorizado"],
      nameResp: json["name_resp"]);

  Map<String, dynamic> toJson() => {
        "Saldo": saldo,
        "estado": estado,
        "id": id,
        "date_begin": date_begin,
        "date_end": date_end,
        "Placaut": placut,
        "Placapr": placpr,
        "document": document,
        "name_autorizado": nameAutorizado,
        "name_resp": nameResp,
      };
}
