// To parse this JSON data, do
//
//     final modelKitapTuru = modelKitapTuruFromJson(jsonString);

import 'dart:convert';

List<ModelKitapTuru> modelKitapTuruFromJsonL(String str) =>
    List<ModelKitapTuru>.from(
        json.decode(str).map((x) => ModelKitapTuru.fromJson(x)));

String modelKitapTuruToJsonL(List<ModelKitapTuru> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ModelKitapTuru modelKitapTuruFromJson(String str) =>
    ModelKitapTuru.fromJson(json.decode(str));

String modelKitapTuruToJson(ModelKitapTuru data) => json.encode(data.toJson());

class ModelKitapTuru {
  final int? id;
  final String? adi;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;

  ModelKitapTuru({
    this.id,
    this.adi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  ModelKitapTuru copyWith({
    int? id,
    String? adi,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
  }) =>
      ModelKitapTuru(
        id: id ?? this.id,
        adi: adi ?? this.adi,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
      );

  factory ModelKitapTuru.fromJson(Map<String, dynamic> json) => ModelKitapTuru(
        id: json["ID"],
        adi: json["Adi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
