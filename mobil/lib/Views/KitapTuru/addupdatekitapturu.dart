import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_turu_controller.dart';

import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';
import 'package:kutuphane_mobil/Views/KitapTuru/kitapturuview.dart';

class AddUpdateKitapTuru extends StatelessWidget {
  AddUpdateKitapTuru({super.key, this.model});
  final ModelKitapTuru? model;
  final TextEditingController turAdiController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.adi != null) {
      turAdiController.text = model!.adi.toString();
      buttonText = "Güncelle";
      idController.text = model!.id.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Türü İşlemleri"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: turAdiController,
              decoration: const InputDecoration(labelText: "Kitap Türü:"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelKitapTuru kitapTuru = ModelKitapTuru(
                  id: int.parse(idController.text),
                  adi: turAdiController.text,
                );
                if (buttonText == "Güncelle") {
                  await Get.put(KitapTuruController()).entityUpdate(
                      "KitapTuru", kitapTuru.id.toString(), kitapTuru);
                } else {
                  await Get.put(KitapTuruController())
                      .postEntity("KitapTuru", kitapTuru);
                }
                List<ModelKitapTuru> d = await Get.put(KitapTuruController())
                    .getAllEntity("KitapTuru");
                Get.to(
                  KitapTuruView(
                    model: d,
                  ),
                );
              },
              child: Text(buttonText ?? "Ekle"),
            )
          ],
        ),
      ),
    );
  }
}
