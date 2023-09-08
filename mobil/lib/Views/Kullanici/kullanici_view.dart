import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kutuphane_mobil/Controllers/kitap_ogrenci_controller.dart';
import 'package:kutuphane_mobil/Controllers/kullanici_controller.dart';

import 'package:kutuphane_mobil/Views/Kullanici/addupdatekullanici.dart';
import 'package:kutuphane_mobil/Views/Kullanici/kullanicidetayview.dart';

import '../../Models/model_kullanici.dart';

//ignore: must_be_immutable
class KullaniciView extends StatelessWidget {
  KullaniciView({super.key, required this.model, this.sayfaSayim});
  final KitapOgrenciController kitapOgrenciController =
      Get.put(KitapOgrenciController());
  final ScrollController _scrollController = ScrollController();
  final kullaniciList = <ModelKullanici>[].obs;
  final kullanici = ModelKullanici();
  final List<ModelKullanici> model;
  final int i = 0;
  String currentSearchValue = "";
  final RxBool isLoading = false.obs;
  int? sayfaSayim;
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    kullaniciList.value = model.toList();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            kullaniciList.addAll(data);

            isLoading.value = false;
            kullaniciList.refresh();
          }
          isLoading.value = false;
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kullanıcı Listesi",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
              ...kullaniciList.asMap().entries.map((e) => GestureDetector(
                    onTap: () async {
                      if (i == 0) {
                        var d = await Get.put(KullaniciController())
                            .getEntity("Kullanici/${e.value.id}");
                        Map<String, dynamic> kullanici = {
                          'KullaniciId': d.id.toString(),
                          'KullaniciAdi': d.kullaniciAdi
                        };

                        kitapOgrenciController.girilenVeriler.addAll(kullanici);
                        Map<String, dynamic> args =
                            kitapOgrenciController.girilenVeriler;
                        Get.back(result: args);
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.person_2_outlined,
                            size: 60,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.value.kullaniciAdi!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            // Text(e.value.barkod!),

                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                height: 50,
                                width: 150,
                                child: IconButton(
                                    onPressed: () async {
                                      var d = await Get.put(
                                              KullaniciController())
                                          .getEntity("Kullanici/${e.value.id}");

                                      Get.to(
                                        KullaniciDetayView(
                                          model: d,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await Get.put(KullaniciController())
                                      .entityDelete(
                                          "Kullanici", e.value.id.toString());
                                  Get.put(KullaniciController())
                                      .getAllEntity("Kullanici")
                                      .then((value) =>
                                          kullaniciList.value = value);
                                },
                                icon:
                                    const Icon(Icons.highlight_remove_rounded)),
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
            Get.to(AddUpdateKullanici());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    temp = 0;
    currentSearchValue = value;
    await Get.put(KullaniciController()).getAllEntityS(
        "Kullanici?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => kullaniciList.value = value);
  }

  Future<List<ModelKullanici>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelKullanici> data =
          await Get.put(KullaniciController()).getAllEntityS(
        "Kullanici?pageCount=$temp&name=$currentSearchValue",
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
