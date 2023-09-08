// To parse this JSON data, do
//
//     final modelResim = modelResimFromJson(jsonString);

import 'dart:convert';

List<ModelResim> modelResimLFromJson(String str) =>
    List<ModelResim>.from(json.decode(str).map((x) => ModelResim.fromJson(x)));

String modelResimLToJson(List<ModelResim> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
List<ModelResim> modelResimFromJson(String str) =>
    List<ModelResim>.from(json.decode(str).map((x) => ModelResim.fromJson(x)));

String modelResimToJson(List<ModelResim> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelResim {
  final int? id;
  final int? kitapId;
  final String? resim1;
  final dynamic kitap;

  ModelResim({
    this.id,
    this.kitapId,
    this.resim1,
    this.kitap,
  });

  ModelResim copyWith({
    int? id,
    int? kitapId,
    dynamic resim1,
    dynamic kitap,
  }) =>
      ModelResim(
        id: id ?? this.id,
        kitapId: kitapId ?? this.kitapId,
        resim1: resim1 ?? this.resim1,
        kitap: kitap ?? this.kitap,
      );

  factory ModelResim.fromJson(Map<String, dynamic> json) => ModelResim(
        id: json["ID"],
        kitapId: json["KitapID"],
        resim1: json["Resim1"],
        kitap: json["Kitap"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "KitapID": kitapId,
        "Resim1": resim1,
        "Kitap": kitap,
      };
}
