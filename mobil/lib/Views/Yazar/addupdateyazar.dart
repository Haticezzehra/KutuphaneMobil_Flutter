import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';

class AddUpdateYazar extends StatelessWidget {
  AddUpdateYazar({super.key, this.model});
  final ModelYazar? model;

  final TextEditingController yazarAdiController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.adSoyad != null) {
      yazarAdiController.text = model!.adSoyad.toString();
      buttonText = "Güncelle";
      idController.text = model!.id.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yazar İşlemleri",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: yazarAdiController,
              decoration: const InputDecoration(labelText: "Yazar Adı:"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelYazar yazar = ModelYazar(
                  id: int.parse(idController.text),
                  adSoyad: yazarAdiController.text,
                );
                if (buttonText == "Güncelle") {
                  await Get.put(YazarController())
                      .entityUpdate("Yazar", yazar.id.toString(), yazar);
                } else {
                  await Get.put(YazarController()).postEntity("Yazar", yazar);
                }
                //entity add

                //
              },
              child: Text(buttonText ?? "Ekle"),
            )
          ],
        ),
      ),
    );
  }
}
