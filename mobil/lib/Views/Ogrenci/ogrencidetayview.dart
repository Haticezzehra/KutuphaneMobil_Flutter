import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil/Models/model_ogrenci.dart';
import 'package:kutuphane_mobil/Views/Ogrenci/ogrenciview.dart';

import 'addupdateogrenci.dart';

class OgrenciDetayView extends StatelessWidget {
  OgrenciDetayView({super.key, required this.model});
  final ogrenci = ModelOgrenci();
  final ogrenciAdiController = TextEditingController();
  final ModelOgrenci model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ogrenciAdiController.text = ogrenci.adSoyad ?? "e";
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Öğrenci Detay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                model.adSoyad!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Bölüm:${model.bolum!}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Sınıf:${model.sinif.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Okul No:${model.okulNo.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                width: 110,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      var d = await Get.put(OgrenciController())
                          .getEntity("Ogrenci/${model.id}");

                      Get.to(
                        AddUpdateOgrenci(
                          model: d,
                        ),
                      );
                    },
                    child: const Text(" Güncelle")),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 110,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await Get.put(OgrenciController())
                        .entityDelete("Ogrenci", model.id.toString());
                    List<ModelOgrenci> data = await Get.put(OgrenciController())
                        .getAllEntity("Ogrenci");
                    Get.to(
                      OgrenciView(model: data),
                    );
                  },
                  child: const Text("Sil")),
            ),
          ]),
        ],
      ),
    );
  }
}
