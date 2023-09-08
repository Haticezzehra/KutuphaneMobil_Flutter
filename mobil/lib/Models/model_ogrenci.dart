// To parse this JSON data, do
//
//     final modelOgrenci = modelOgrenciFromJson(jsonString);

import 'dart:convert';

List<ModelOgrenci> modelOgrenciFromJsonL(String str) => List<ModelOgrenci>.from(
    json.decode(str).map((x) => ModelOgrenci.fromJson(x)));

String modelOgrenciToJsonL(List<ModelOgrenci> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ModelOgrenci modelOgrenciFromJson(String str) =>
    ModelOgrenci.fromJson(json.decode(str));

String modelOgrenciToJson(ModelOgrenci data) => json.encode(data.toJson());

class ModelOgrenci {
  final int? id;
  final String? adSoyad;
  final String? sinif;
  final String? bolum;
  final String? okulNo;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;

  ModelOgrenci({
    this.id,
    this.adSoyad,
    this.sinif,
    this.bolum,
    this.okulNo,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  ModelOgrenci copyWith({
    int? id,
    String? adSoyad,
    String? sinif,
    String? bolum,
    String? okulNo,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
  }) =>
      ModelOgrenci(
        id: id ?? this.id,
        adSoyad: adSoyad ?? this.adSoyad,
        sinif: sinif ?? this.sinif,
        bolum: bolum ?? this.bolum,
        okulNo: okulNo ?? this.okulNo,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
      );

  factory ModelOgrenci.fromJson(Map<String, dynamic> json) => ModelOgrenci(
        id: json["ID"],
        adSoyad: json["AdSoyad"],
        sinif: json["Sinif"],
        bolum: json["Bolum"],
        okulNo: json["OkulNo"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AdSoyad": adSoyad,
        "Sinif": sinif,
        "Bolum": bolum,
        "OkulNo": okulNo,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
