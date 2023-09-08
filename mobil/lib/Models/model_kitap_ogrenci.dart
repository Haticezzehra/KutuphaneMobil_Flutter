// To parse this JSON data, do
//
//     final modelKitapOgrenci = modelKitapOgrenciFromJson(jsonString);

import 'dart:convert';

List<ModelKitapOgrenci> modelKitapOgrenciLFromJson(String str) =>
    List<ModelKitapOgrenci>.from(
        json.decode(str).map((x) => ModelKitapOgrenci.fromJson(x)));

String modelKitapOgrenciLToJson(List<ModelKitapOgrenci> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
ModelKitapOgrenci modelKitapOgrenciFromJson(String str) =>
    ModelKitapOgrenci.fromJson(json.decode(str));

String modelKitapOgrenciToJson(ModelKitapOgrenci data) =>
    json.encode(data.toJson());

class ModelKitapOgrenci {
  final int? id;
  final String? ogrenciAd;
  final int? ogrenciId;
  final int? kitapId;
  final String? kitapAdi;
  final int? kullaniciId;
  final String? kullaniciAdi;
  final String? alisTarihi;
  final String? teslimTarihi;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;

  ModelKitapOgrenci({
    this.id,
    this.ogrenciAd,
    this.ogrenciId,
    this.kitapId,
    this.kitapAdi,
    this.kullaniciId,
    this.kullaniciAdi,
    this.alisTarihi,
    this.teslimTarihi,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
  });

  ModelKitapOgrenci copyWith({
    int? id,
    String? ogrenciAd,
    int? ogrenciId,
    int? kitapId,
    String? kitapAdi,
    int? kullaniciId,
    String? kullaniciAdi,
    String? alisTarihi,
    String? teslimTarihi,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
  }) =>
      ModelKitapOgrenci(
        id: id ?? this.id,
        ogrenciAd: ogrenciAd ?? this.ogrenciAd,
        ogrenciId: ogrenciId ?? this.ogrenciId,
        kitapId: kitapId ?? this.kitapId,
        kitapAdi: kitapAdi ?? this.kitapAdi,
        kullaniciId: kullaniciId ?? this.kullaniciId,
        kullaniciAdi: kullaniciAdi ?? this.kullaniciAdi,
        alisTarihi: alisTarihi ?? this.alisTarihi,
        teslimTarihi: teslimTarihi ?? this.teslimTarihi,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
      );

  factory ModelKitapOgrenci.fromJson(Map<String, dynamic> json) =>
      ModelKitapOgrenci(
        id: json["ID"],
        ogrenciAd: json["OgrenciAdi"],
        ogrenciId: json["OgrenciID"],
        kitapId: json["KitapID"],
        kitapAdi: json["KitapAdi"],
        kullaniciId: json["KullaniciID"],
        kullaniciAdi: json["KullaniciAdi"],
        alisTarihi: json["AlisTarihi"],
        teslimTarihi: json["TeslimTarihi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "OgrenciAdı": ogrenciAd,
        "OgrenciID": ogrenciId,
        "KitapID": kitapId,
        "kitapAdi": kitapAdi,
        "KullaniciID": kullaniciId,
        "KullaniciAdi": kullaniciAdi,
        "AlisTarihi": alisTarihi,
        "TeslimTarihi": teslimTarihi,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
      };
}
