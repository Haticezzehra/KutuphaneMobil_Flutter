import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Models/model_kitap_ogrenci.dart';
import 'package:kutuphane_mobil/Views/KitapOgrenci/addupdatekitapogrenci.dart';
import 'package:kutuphane_mobil/Views/KitapOgrenci/kitapogrenciview.dart';

import '../../Controllers/kitap_ogrenci_controller.dart';

class KitapOgrenciDetay extends StatelessWidget {
  KitapOgrenciDetay({super.key, required this.model});
  final kitapOgrenci = ModelKitapOgrenci();
  final kitapController = TextEditingController();
  final ModelKitapOgrenci model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kitapController.text = kitapOgrenci.ogrenciAd ?? "e";
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text("Kitap Adı:  ${model.kitapAdi!}"),
              Text("Ogrenci Adı:  ${model.ogrenciAd!}"),
              //Buraya Alma tarihi ve teslim tarihi ekl
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              width: 110,
              child: ElevatedButton(
                  onPressed: () async {
                    var d = await Get.put(KitapOgrenciController())
                        .getEntity("KitapOgrenci/${model.id}");

                    Get.to(
                      AddUpdateKitapOgrenci(
                        model: d,
                      ),
                    );
                  },
                  child: const Text("Güncelle")),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              width: 110,
              child: ElevatedButton(
                  onPressed: () async {
                    await Get.put(KitapOgrenciController())
                        .entityDelete("KitapOgrenci", model.id.toString());
                    List<ModelKitapOgrenci> data =
                        await Get.put(KitapOgrenciController())
                            .getAllEntity("KitapOgrenci");
                    Get.to(
                      KitapOgrenciView(model: data),
                    );
                  },
                  child: const Text("Sil")),
            )
          ]),
        ],
      ),
    );
  }
}
