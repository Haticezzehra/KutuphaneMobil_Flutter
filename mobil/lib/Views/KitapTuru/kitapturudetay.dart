import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';

import '../../Controllers/kitap_turu_controller.dart';
import 'addupdatekitapturu.dart';
import 'kitapturuview.dart';

class KitapTuruDetayView extends StatelessWidget {
  KitapTuruDetayView({super.key, required this.model});
  final kitap = ModelKitapTuru();
  final kitapTuruController = TextEditingController();
  final ModelKitapTuru model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kitapTuruController.text = kitap.adi ?? "e";
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
              Column(
                children: [
                  Text(model.adi!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () async {
                              var d = await Get.put(KitapTuruController())
                                  .getEntity("KitapTuru/${model.id}");

                              Get.to(
                                AddUpdateKitapTuru(
                                  model: d,
                                ),
                              );
                            },
                            child: const Text(" Güncelle")),
                      ),
                      Container(
                        width: 110,
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () async {
                              await Get.put(KitapTuruController()).entityDelete(
                                  "KitapTuru", model.id.toString());
                              List<ModelKitapTuru> data =
                                  await Get.put(KitapTuruController())
                                      .getAllEntity("KitapTuru");
                              Get.to(
                                KitapTuruView(model: data),
                              );
                            },
                            child: const Text("Sil")),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
