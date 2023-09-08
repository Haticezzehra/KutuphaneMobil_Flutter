import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Controllers/kitap_ogrenci_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap_ogrenci.dart';
import 'package:kutuphane_mobil/Views/KitapOgrenci/addupdatekitapogrenci.dart';
import 'package:kutuphane_mobil/Views/KitapOgrenci/kitapogrencidetay.dart';

//ignore: must_be_immutable
class KitapOgrenciView extends StatelessWidget {
  KitapOgrenciView({super.key, required this.model, this.sayfaSayim, this.i});

  final ScrollController _scrollController = ScrollController();
  final kitapogrenciList = <ModelKitapOgrenci>[].obs;
  final List<ModelKitapOgrenci> model;
  int? i = 0;
  String currentSearchValue = "";
  final RxBool isLoading = false.obs;
  int? sayfaSayim;
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    kitapogrenciList.value = model.toList();

    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            kitapogrenciList.addAll(data);

            isLoading.value = false;
            kitapogrenciList.refresh();
          }
          isLoading.value = false;
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Öğrenci Listesi"),
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
                    ...kitapogrenciList.asMap().entries.map(
                          (e) => GestureDetector(
                            onTap: () async {},
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                height: 120,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.book,
                                      size: 60,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Kitap Adı:${e.value.kitapAdi!}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Teslim Alan:${e.value.ogrenciAd!}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: IconButton(
                                              onPressed: () async {
                                                var d = await Get.put(
                                                        KitapOgrenciController())
                                                    .getEntity(
                                                        "KitapOgrenci/${e.value.id}");

                                                Get.to(
                                                  KitapOgrenciDetay(
                                                    model: d,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await Get.put(
                                                        KitapOgrenciController())
                                                    .entityDelete(
                                                        "KitapOgrenci",
                                                        e.value.id.toString());
                                                Get.put(KitapOgrenciController())
                                                    .getAllEntity(
                                                        "KitapOgrenci")
                                                    .then((value) =>
                                                        kitapogrenciList.value =
                                                            value);
                                              },
                                              icon: const Icon(Icons
                                                  .highlight_remove_rounded)),
                                        ])
                                  ],
                                ),
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
            Get.to(AddUpdateKitapOgrenci());
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    temp = 0;
    currentSearchValue = value;
    await Get.put(KitapOgrenciController()).getAllEntityS(
        "KitapOgrenci?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => kitapogrenciList.value = value);
  }

  Future<List<ModelKitapOgrenci>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelKitapOgrenci> data =
          await Get.put(KitapOgrenciController()).getAllEntityS(
        "KitapOgrenci?pageCount=$temp&name=$currentSearchValue",
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
