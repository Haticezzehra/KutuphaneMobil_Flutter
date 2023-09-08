import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';
import 'package:kutuphane_mobil/Views/Yazar/addupdateyazar.dart';
import 'package:kutuphane_mobil/Views/Yazar/yazardetay.dart';

import '../../Controllers/yazar_controller.dart';

//ignore: must_be_immutable
class YazarView extends StatelessWidget {
  YazarView({
    super.key,
    required this.model,
    this.sayfaSayim,
  });
  final KitapController kitapController = Get.put(KitapController());
  final ScrollController _scrollController = ScrollController();
  final yazarList = <ModelYazar>[].obs;
  final List<ModelYazar> model;
  int? i = 0;
  String currentSearchValue = "";
  final RxBool isLoading = false.obs;
  int? sayfaSayim;
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    yazarList.value = model.toList();

    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            yazarList.addAll(data);

            isLoading.value = false;
            yazarList.refresh();
          }
          isLoading.value = false;
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yazar Listesi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                    ...yazarList.asMap().entries.map(
                          (e) => GestureDetector(
                            onTap: () async {
                              if (i == 0) {
                                var d = await Get.put(YazarController())
                                    .getEntity("Yazar/${e.value.id}");
                                Map<String, dynamic> yazar = {
                                  'yazarId': e.value.id.toString(),
                                  'yazarAdi': d.adSoyad
                                };

                                kitapController.girilenVeriler.addAll(yazar);
                                Map<String, dynamic> args =
                                    kitapController.girilenVeriler;
                                Get.back(result: args);
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.person_outline_rounded,
                                    size: 60,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.value.adSoyad!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: SizedBox(
                                            height: 50,
                                            width: 150,
                                            child: IconButton(
                                              onPressed: () async {
                                                var d = await Get.put(
                                                        YazarController())
                                                    .getEntity(
                                                        "Yazar/${e.value.id}");

                                                Get.to(
                                                  YazarDetayView(
                                                    model: d,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await Get.put(YazarController())
                                                  .entityDelete("Yazar",
                                                      e.value.id.toString());
                                              Get.put(YazarController())
                                                  .getAllEntity("Yazar")
                                                  .then((value) =>
                                                      yazarList.value = value);
                                            },
                                            icon: const Icon(Icons
                                                .highlight_remove_rounded)),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
      ),
      persistentFooterButtons: [
        IconButton(
          onPressed: () {
            Get.to(AddUpdateYazar());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    temp = 0;
    currentSearchValue = value;
    await Get.put(YazarController()).getAllEntityS(
        "Yazar?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => yazarList.value = value);
  }

  Future<List<ModelYazar>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelYazar> data = await Get.put(YazarController()).getAllEntityS(
        "Yazar?pageCount=$temp&name=$currentSearchValue",
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
