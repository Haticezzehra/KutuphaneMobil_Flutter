import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';

import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/yayineviview.dart';

class AddUpdateYayinEvi extends StatelessWidget {
  AddUpdateYayinEvi({super.key, this.model});
  final ModelYayinEvi? model;
  final TextEditingController yayinEviAdiController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.id != null) {
      yayinEviAdiController.text = model!.ad.toString();
      buttonText = " Güncelle";
      idController.text = model!.id.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("YayinEvi İşlemleri"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: yayinEviAdiController,
              decoration: const InputDecoration(
                labelText: "Yayin Evi",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelYayinEvi yayinEvi = ModelYayinEvi(
                  ad: yayinEviAdiController.text,
                );
                if (buttonText == " Güncelle") {
                  await Get.put(YayinEviController()).entityUpdate(
                      "YayinEvi", yayinEvi.id.toString(), yayinEvi);
                } else {
                  await Get.put(YayinEviController())
                      .postEntity("YayinEvi", yayinEvi);
                }
                List<ModelYayinEvi> data = await Get.put(
                    YayinEviController().getAllEntity("YayinEvi"));
                Get.to(YayinEviView(
                  model: data,
                ));
              },
              child: Text(buttonText ?? " Ekle"),
            )
          ],
        ),
      ),
    );
  }
}
