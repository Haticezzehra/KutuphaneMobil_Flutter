// To parse this JSON data, do
//
//     final modelKitap = modelKitapFromJson(jsonString);

import 'dart:convert';

List<ModelKitap> modelKitapLFromJson(String str) =>
    List<ModelKitap>.from(json.decode(str).map((x) => ModelKitap.fromJson(x)));

String modelKitapLToJson(List<ModelKitap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
ModelKitap modelKitapFromJson(String str) =>
    ModelKitap.fromJson(json.decode(str));

String modelKitapToJson(ModelKitap data) => json.encode(data.toJson());

class ModelKitap {
  final int? id;
  final String? adi;
  final int? sayfaSayisi;
  final String? kitapTurAdi;
  final int? kitapTurId;
  final String? yayinEviAdi;
  final int? yayinEviId;
  final String? yazarAdi;
  final int? yazarId;
  final String? barkod;
  final String? kayitYapan;
  final String? kayitTarihi;
  final String? degisiklikYapan;
  final String? degisiklikTarihi;
  // final List<dynamic>? resim;

  ModelKitap({
    this.id,
    this.adi,
    this.sayfaSayisi,
    this.kitapTurAdi,
    this.kitapTurId,
    this.yayinEviAdi,
    this.yayinEviId,
    this.yazarAdi,
    this.yazarId,
    this.barkod,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
    //this.resim
  });

  ModelKitap copyWith({
    int? id,
    String? adi,
    int? sayfaSayisi,
    String? kitapTurAdi,
    int? kitapTurId,
    String? yayinEviAdi,
    int? yayinEviId,
    String? yazarAdi,
    int? yazarId,
    String? barkod,
    String? kayitYapan,
    String? kayitTarihi,
    String? degisiklikYapan,
    String? degisiklikTarihi,
    // List<dynamic>? resim,
  }) =>
      ModelKitap(
        id: id ?? this.id,
        adi: adi ?? this.adi,
        sayfaSayisi: sayfaSayisi ?? this.sayfaSayisi,
        kitapTurAdi: kitapTurAdi ?? this.kitapTurAdi,
        kitapTurId: kitapTurId ?? this.kitapTurId,
        yayinEviAdi: yayinEviAdi ?? this.yayinEviAdi,
        yayinEviId: yayinEviId ?? this.yayinEviId,
        yazarAdi: yazarAdi ?? this.yazarAdi,
        yazarId: yazarId ?? this.yazarId,
        barkod: barkod ?? this.barkod,
        kayitYapan: kayitYapan ?? this.kayitYapan,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        degisiklikYapan: degisiklikYapan ?? this.degisiklikYapan,
        degisiklikTarihi: degisiklikTarihi ?? this.degisiklikTarihi,
        //  resim: resim ?? this.resim,
      );

  factory ModelKitap.fromJson(Map<String, dynamic> json) => ModelKitap(
        id: json["ID"],
        adi: json["Adi"],
        sayfaSayisi: json["SayfaSayisi"],
        kitapTurAdi: json["KitapTurAdi"],
        kitapTurId: json["KitapTurID"],
        yayinEviAdi: json["YayinEviAdi"],
        yayinEviId: json["YayinEviID"],
        yazarAdi: json["YazarAdi"],
        yazarId: json["YazarID"],
        barkod: json["Barkod"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        // resim: json["Resim"] == null
        //     ? []
        //     : List<dynamic>.from(json["Resim"]!.map((x) => x)
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": adi,
        "SayfaSayisi": sayfaSayisi,
        "KitapTurAdi": kitapTurAdi,
        "KitapTurID": kitapTurId,
        "YayinEviAdi": yayinEviAdi,
        "YayinEviID": yayinEviId,
        "YazarAdi": yazarAdi,
        "YazarID": yazarId,
        "Barkod": barkod,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        //"Resim": resim == null ? [] : List<dynamic>.from(resim!.map((x) => x)),
      };
}
