import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kullanici_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_kullanici.dart';
import 'package:kutuphane_mobil/Views/Kullanici/addupdatekullanici.dart';
import 'package:kutuphane_mobil/Views/Kullanici/kullanici_view.dart';

class KullaniciDetayView extends StatelessWidget {
  KullaniciDetayView({super.key, required this.model});
  final kullanici = ModelKitap();
  final kitapController = TextEditingController();
  final ModelKullanici model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kitapController.text = kullanici.adi ?? "e";
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
              Text(
                model.kullaniciAdi!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      var d = await Get.put(KullaniciController())
                          .getEntity("Kullanici/${model.id}");

                      Get.to(
                        AddUpdateKullanici(
                          model: d,
                        ),
                      );
                    },
                    child: const Text("Güncelle")),
              ),
              Container(
                width: 110,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      await Get.put(KullaniciController())
                          .entityDelete("Kullanici", model.id.toString());
                      List<ModelKullanici> data =
                          await Get.put(KullaniciController())
                              .getAllEntity("Kullanici");
                      Get.to(
                        KullaniciView(model: data),
                      );
                    },
                    child: const Text("Sil")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
