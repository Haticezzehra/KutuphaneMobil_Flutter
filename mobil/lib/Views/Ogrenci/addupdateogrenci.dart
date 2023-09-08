import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Controllers/ogrenci_controller.dart';

import 'package:kutuphane_mobil/Models/model_ogrenci.dart';

class AddUpdateOgrenci extends StatelessWidget {
  AddUpdateOgrenci({super.key, this.model});
  final ModelOgrenci? model;
  final TextEditingController ogrenciAdiController = TextEditingController();
  final TextEditingController sinifController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController bolumController = TextEditingController();
  final TextEditingController okulNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.id != null) {
      ogrenciAdiController.text = model!.adSoyad.toString();
      buttonText = "Ogrenci Güncelle";
      idController.text = model!.id.toString();
      sinifController.text = model!.sinif.toString();
      bolumController.text = model!.bolum.toString();
      okulNoController.text = model!.okulNo.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Öğrenci İşlemleri",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: ogrenciAdiController,
              decoration: const InputDecoration(labelText: "Öğrenci Adı:"),
            ),
            TextField(
              controller: bolumController,
              decoration: const InputDecoration(labelText: "Bölüm:"),
            ),
            TextField(
              controller: sinifController,
              decoration: const InputDecoration(labelText: "Sınıf:"),
            ),
            TextField(
              controller: okulNoController,
              decoration: const InputDecoration(labelText: "Okul No:"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelOgrenci ogrenci = ModelOgrenci(
                  id: int.parse(idController.text),
                  adSoyad: ogrenciAdiController.text,
                  bolum: bolumController.text,
                  okulNo: okulNoController.text,
                  sinif: sinifController.text,
                );
                if (buttonText == "Ogrenci Güncelle") {
                  await Get.put(OgrenciController())
                      .entityUpdate("Ogrenci", ogrenci.id.toString(), ogrenci);
                } else {
                  await Get.put(OgrenciController())
                      .postEntity("Ogrenci", ogrenci);
                }
                //entity add

                //
              },
              child: Text(buttonText ?? "Ogrenci Ekle"),
            )
          ],
        ),
      ),
    );
  }
}
