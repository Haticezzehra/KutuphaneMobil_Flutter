// To parse this JSON data, do
//
//     final modelKitapKullanici = modelKitapKullaniciFromJson(jsonString);

import 'dart:convert';

List<ModelKullanici> modelKitapKullaniciFromJsonL(String str) =>
    List<ModelKullanici>.from(
        json.decode(str).map((x) => ModelKullanici.fromJson(x)));

String modelKitapKullaniciToJsonL(List<ModelKullanici> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
ModelKullanici modelKitapKullaniciFromJson(String str) =>
    ModelKullanici.fromJson(json.decode(str));

String modelKitapKullaniciToJson(ModelKullanici data) =>
    json.encode(data.toJson());

class ModelKullanici {
  final int? id;
  final String? kullaniciAdi;
  final String? parola;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;

  ModelKullanici({
    this.id,
    this.kullaniciAdi,
    this.parola,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  ModelKullanici copyWith({
    int? id,
    String? kullaniciAdi,
    String? parola,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
  }) =>
      ModelKullanici(
        id: id ?? this.id,
        kullaniciAdi: kullaniciAdi ?? this.kullaniciAdi,
        parola: parola ?? this.parola,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
      );

  factory ModelKullanici.fromJson(Map<String, dynamic> json) => ModelKullanici(
        id: json["ID"],
        kullaniciAdi: json["KullaniciAdi"],
        parola: json["Parola"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "KullaniciAdi": kullaniciAdi,
        "Parola": parola,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
