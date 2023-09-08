import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_ogrenci_controller.dart';
import 'package:kutuphane_mobil/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil/Models/model_ogrenci.dart';
import 'package:kutuphane_mobil/Views/Ogrenci/addupdateogrenci.dart';
import 'package:kutuphane_mobil/Views/Ogrenci/ogrencidetayview.dart';

//ignore: must_be_immutable
class OgrenciView extends StatelessWidget {
  OgrenciView({super.key, required this.model, this.sayfaSayim, this.i});
  final KitapOgrenciController kitapController =
      Get.put(KitapOgrenciController());
  final ScrollController _scrollController = ScrollController();
  final ogrenciList = <ModelOgrenci>[].obs;
  final ogrenci = ModelOgrenci();
  String currentSearchValue = "";
  final List<ModelOgrenci> model;
  final RxBool isLoading = false.obs;
  String searchValue = "";
  int temp = 0;
  int? sayfaSayim;
  int? i = 0;
  @override
  Widget build(BuildContext context) {
    ogrenciList.value = model.toList();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            ogrenciList.addAll(data);

            isLoading.value = false;
            ogrenciList.refresh();
          }
          isLoading.value = false;
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Öğrenci Listesi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Here...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                onChanged: _onSearch,
              ),
              ...ogrenciList.asMap().entries.map((e) => GestureDetector(
                    onTap: () async {
                      if (i == 0) {
                        var d = await Get.put(OgrenciController())
                            .getEntity("Ogrenci/${e.value.id}");
                        Map<String, dynamic> ogrenci = {
                          'OgrenciId': d.id.toString(),
                          'OgrenciAdi': d.adSoyad
                        };

                        kitapController.girilenVeriler.addAll(ogrenci);
                        Map<String, dynamic> args =
                            kitapController.girilenVeriler;
                        Get.back(result: args);
                      }
                    },
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, // Düğm
                            children: [
                              const Icon(
                                Icons.book,
                                size: 60,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.value.adSoyad!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.value.bolum!),
                                  ),
                                ],
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: IconButton(
                                          onPressed: () async {
                                            var d = await Get.put(
                                                    OgrenciController())
                                                .getEntity(
                                                    "Ogrenci/${e.value.id}");

                                            Get.to(
                                              OgrenciDetayView(
                                                model: d,
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit)),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await Get.put(OgrenciController())
                                              .entityDelete("Ogrenci",
                                                  e.value.id.toString());
                                          Get.put(OgrenciController())
                                              .getAllEntity("Ogrenci")
                                              .then((value) =>
                                                  ogrenciList.value = value);
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove_rounded)),
                                  ])
                            ]),
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
            Get.to(AddUpdateOgrenci());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    currentSearchValue = value; // Arama değerini sakla
    searchValue = value;
    temp = 0;
    await Get.put(OgrenciController()).getAllEntityS(
        "Ogrenci?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => ogrenciList.value = value);
  }

  Future<List<ModelOgrenci>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelOgrenci> data =
          await Get.put(OgrenciController()).getAllEntityS(
        "Ogrenci?pageCount=$temp&name=$currentSearchValue",
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
