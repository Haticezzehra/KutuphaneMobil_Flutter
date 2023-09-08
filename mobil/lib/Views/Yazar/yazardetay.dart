import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';
import 'package:kutuphane_mobil/Views/Yazar/yazarview.dart';

import '../../Controllers/yazar_controller.dart';
import 'addupdateyazar.dart';

class YazarDetayView extends StatelessWidget {
  YazarDetayView({super.key, required this.model});
  final yazar = ModelYazar();
  final yazarController = TextEditingController();
  final ModelYazar model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      yazarController.text = yazar.adSoyad ?? "e";
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Detay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(model.adSoyad!,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      var d = await Get.put(YazarController())
                          .getEntity("Yazar/${model.id}");

                      Get.to(
                        AddUpdateYazar(
                          model: d,
                        ),
                      );
                    },
                    child: const Text("Güncelle")),
              ),
              SizedBox(
                width: 110,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      await Get.put(YazarController())
                          .entityDelete("Yazar", model.id.toString());
                      List<ModelYazar> data = await Get.put(YazarController())
                          .getAllEntity("Yazar");
                      Get.to(
                        YazarView(model: data),
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
