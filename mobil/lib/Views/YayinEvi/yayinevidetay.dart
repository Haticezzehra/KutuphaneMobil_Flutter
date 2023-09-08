import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/addupdateyayinevi.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/yayineviview.dart';

class YayinEviDetayView extends StatelessWidget {
  YayinEviDetayView({super.key, required this.model});
  final yayinEvi = ModelYayinEvi();
  final yayinEviAdiController = TextEditingController();
  final ModelYayinEvi model;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      yayinEviAdiController.text = yayinEvi.ad ?? "e";
    });

    return Scaffold(
      appBar: AppBar(
        title:
            const Text(" Detay", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                model.ad!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 110,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    var d = await Get.put(YayinEviController())
                        .getEntity("YayinEvi/${model.id}");

                    Get.to(
                      AddUpdateYayinEvi(
                        model: d,
                      ),
                    );
                  },
                  child: const Text(" Güncelle")),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 110,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await Get.put(YayinEviController())
                        .entityDelete("YayinEvi", model.id.toString());
                    List<ModelYayinEvi> data =
                        await Get.put(YayinEviController())
                            .getAllEntity("YayinEvi");
                    Get.to(
                      YayinEviView(model: data),
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
