import 'dart:convert';

List<ModelYayinEvi> modelYayinEviLFromJson(String str) =>
    List<ModelYayinEvi>.from(
        json.decode(str).map((x) => ModelYayinEvi.fromJson(x)));

String modelYayinEviLToJson(List<ModelYayinEvi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
ModelYayinEvi modelYayinEviFromJson(String str) =>
    ModelYayinEvi.fromJson(json.decode(str));

String modelYayinEviToJson(ModelYayinEvi data) => json.encode(data.toJson());

class ModelYayinEvi {
  int? id;
  String? ad;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  // List<dynamic>? kitap;

  ModelYayinEvi({
    this.id,
    this.ad,
    this.kayitYapan,
    this.kayitTarihi,
    this.degisiklikYapan,
    this.degisiklikTarihi,
    // required this.kitap,
  });

  ModelYayinEvi.isimlendirilmis();
  factory ModelYayinEvi.fromRawJson(String str) =>
      ModelYayinEvi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelYayinEvi.fromJson(Map<String, dynamic> json) => ModelYayinEvi(
        id: json["ID"],
        ad: json["Adi"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        // kitap: List<dynamic>.from(json["Kitap"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Adi": ad,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        //"Kitap": List<dynamic>.from(kitap.map((x) => x)),
      };
}
