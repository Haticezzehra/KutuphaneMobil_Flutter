import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/resim_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_resim.dart';
import 'package:kutuphane_mobil/Views/Kitap/addupdatekitap.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitap_resim_view.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitapview.dart';

import '../../Controllers/kitap_controller.dart';

//ignore: must_be_immutable
class KitapDetayView extends StatelessWidget {
  KitapDetayView({super.key, required this.model, this.resimmodel});
  final kitap = ModelKitap();
  var filtreli = 0.obs;
  final kitapController = TextEditingController();
  final ModelKitap model;
  List<ModelResim>? resimmodel;
  final resimList = <ModelResim>[].obs;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kitapController.text = kitap.adi ?? "e";
    });
    if (resimmodel != null) {
      resimList.value =
          resimmodel!.where((item) => item.kitapId == model.id).toList();
    }
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Detay", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              model.adi ?? "",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              resimList.isEmpty
                  ? const Icon(
                      Icons.book,
                      size: 200,
                    )
                  : buildImageFromByte(resimList[0].resim1.toString()),
              Text("Yazar :${model.yazarAdi ?? ""}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                "Yayın Evi:${model.yayinEviAdi ?? ""}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          var d = await Get.put(KitapController())
                              .getEntity("Kitap/${model.id}");

                          Get.to(
                            AddUpdateKitap(
                              model: d,
                            ),
                          );
                        },
                        child: const Text(" Güncelle")),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 110,
                      height: 50,
                      child: ElevatedButton(
                          child: const Text("Resimler"),
                          onPressed: () async {
                            List<ModelResim> resimler =
                                await Get.put(ResimController())
                                    .getAllEntity("Resim");

                            Get.to(() =>
                                KitapResimView(model: resimler, id: model.id));
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          await Get.put(KitapController())
                              .entityDelete("Kitap", model.id.toString());
                          List<ModelKitap> data =
                              await Get.put(KitapController()).getAllEntityS(
                                  "Kitap?pageCount=0", func: (sayfaSayisi) {
                            filtreli.value = sayfaSayisi!;
                          });
                          Get.to(
                            KitapView(
                              model: data,
                              sayfaSayim: filtreli,
                            ),
                          );
                        },
                        child: const Text("Sil")),
                  ),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildImageFromByte(String baseString) {
    // Byte dizisinin base64 kodlaması
    Uint8List bytes = base64Decode(baseString);
    return Image.memory(
      errorBuilder: (context, error, stackTrace) {
        return const Text("Resim Yok");
      },
      bytes,
      width: 250,
      height: 300,
      fit: BoxFit.fill,
    );
  }
}
