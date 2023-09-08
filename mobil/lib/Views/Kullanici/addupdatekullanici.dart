import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Controllers/kullanici_controller.dart';

import 'package:kutuphane_mobil/Models/model_kullanici.dart';

class AddUpdateKullanici extends StatelessWidget {
  AddUpdateKullanici({super.key, this.model});
  final ModelKullanici? model;
  final TextEditingController kullaniciAdiController = TextEditingController();
  final TextEditingController parolaController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.kullaniciAdi != null) {
      kullaniciAdiController.text = model!.kullaniciAdi.toString();
      buttonText = "Kullanıcı Güncelle";
      idController.text = model!.id.toString();
      parolaController.text = model!.parola.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı İşlemleri"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: kullaniciAdiController,
              decoration: const InputDecoration(labelText: "Kullanıcı Adı:"),
            ),
            TextField(
              controller: parolaController,
              decoration: const InputDecoration(labelText: "Parola"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelKullanici kullanici = ModelKullanici(
                  id: int.parse(idController.text),
                  kullaniciAdi: kullaniciAdiController.text,
                  parola: parolaController.text,
                );
                if (buttonText == "Kullanıcı Güncelle") {
                  await Get.put(KullaniciController()).entityUpdate(
                      "Kullanici", kullanici.id.toString(), kullanici);
                } else {
                  await Get.put(KullaniciController())
                      .postEntity("Kullanici", kullanici);
                }
                //entity add

                //
              },
              child: Text(buttonText ?? "Kullanıcı Ekle"),
            )
          ],
        ),
      ),
    );
  }
}
