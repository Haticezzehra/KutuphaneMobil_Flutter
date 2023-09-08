import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Controllers/kitap_turu_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';
import 'package:kutuphane_mobil/Views/KitapTuru/addupdatekitapturu.dart';
import 'package:kutuphane_mobil/Views/KitapTuru/kitapturudetay.dart';

//ignore: must_be_immutable
class KitapTuruView extends StatelessWidget {
  KitapTuruView({super.key, required this.model, this.sayfaSayim});
  final KitapController kitapController = Get.put(KitapController());
  final ScrollController _scrollController = ScrollController();
  final List<ModelKitapTuru> model;
  final kitapTuruList = <ModelKitapTuru>[].obs;
  final kitapTuru = ModelKitapTuru();
  final int i = 0;
  final RxBool isLoading = false.obs;
  int? sayfaSayim;
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    kitapTuruList.value = model.toList();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            kitapTuruList.addAll(data);

            isLoading.value = false;
            kitapTuruList.refresh();
          }
          isLoading.value = false;
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Türü Listesi"),
      ),
      body: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(), // Yükleme animasyonu
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search Here...',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      onChanged: _onSearch,
                    ),
                    ...kitapTuruList.asMap().entries.map((e) => GestureDetector(
                          onTap: () async {
                            if (i == 0) {
                              var d = await Get.put(KitapTuruController())
                                  .getEntity("KitapTuru/${e.value.id}");
                              Map<String, dynamic> kitapTur = {
                                'kitapTurID': e.value.id.toString(),
                                'kitapTurAdi': d.adi
                              };

                              kitapController.girilenVeriler.addAll(kitapTur);
                              Map<String, dynamic> args =
                                  kitapController.girilenVeriler;
                              Get.back(result: args);
                            }
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.adobe_rounded,
                                  size: 60,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.value.adi!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: IconButton(
                                        onPressed: () async {
                                          var d = await Get.put(
                                                  KitapTuruController())
                                              .getEntity(
                                                  "KitapTuru/${e.value.id}");

                                          Get.to(
                                            KitapTuruDetayView(
                                              model: d,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: IconButton(
                                        onPressed: () async {
                                          await Get.put(KitapTuruController())
                                              .entityDelete("KitapTuru",
                                                  e.value.id.toString());
                                          Get.put(KitapTuruController())
                                              .getAllEntity("KitapTuru")
                                              .then((value) =>
                                                  kitapTuruList.value = value);
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove_rounded)),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
      ),
      persistentFooterButtons: [
        IconButton(
          onPressed: () {
            Get.to(AddUpdateKitapTuru());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    await Get.put(KitapTuruController()).getAllEntityS("KitapTuru?name=$value",
        func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => kitapTuruList.value = value);
  }

  Future<List<ModelKitapTuru>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelKitapTuru> data =
          await Get.put(KitapTuruController()).getAllEntityS(
        "KitapTuru?pageCount=$temp",
        func: (sayfaSayisi) {
          sayfaSayim = sayfaSayisi;
        },
      );
      return data;
    } else {
      return null;
    }
  }
}
