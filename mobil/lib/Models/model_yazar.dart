// To parse this JSON data, do
//
//     final modelYazar = modelYazarFromJson(jsonString);

import 'dart:convert';

List<ModelYazar> modelYazarFromJsonL(String str) =>
    List<ModelYazar>.from(json.decode(str).map((x) => ModelYazar.fromJson(x)));

String modelYazarToJsonL(List<ModelYazar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
ModelYazar modelYazarFromJson(String str) =>
    ModelYazar.fromJson(json.decode(str));

String modelYazarToJson(ModelYazar data) => json.encode(data.toJson());

class ModelYazar {
  final int? id;
  final String? adSoyad;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;

  ModelYazar({
    this.id,
    this.adSoyad,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  ModelYazar copyWith({
    int? id,
    String? adSoyad,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
  }) =>
      ModelYazar(
        id: id ?? this.id,
        adSoyad: adSoyad ?? this.adSoyad,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
      );

  factory ModelYazar.fromJson(Map<String, dynamic> json) => ModelYazar(
        id: json["ID"],
        adSoyad: json["AdSoyad"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdSoyad": adSoyad,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
