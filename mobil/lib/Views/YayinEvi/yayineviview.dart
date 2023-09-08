import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';

import 'package:kutuphane_mobil/Views/YayinEvi/addupdateyayinevi.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/yayinevidetay.dart';

//ignore: must_be_immutable
class YayinEviView extends StatelessWidget {
  YayinEviView({super.key, required this.model, this.sayfaSayim});
  final KitapController kitapController = Get.put(KitapController());
  final ScrollController _scrollController = ScrollController();
  String currentSearchValue = "";
  final yayinEviList = <ModelYayinEvi>[].obs;
  final yayinEvi = ModelYayinEvi();
  final List<ModelYayinEvi> model;
  final int i = 0;
  final RxBool isLoading = false.obs;
  int? sayfaSayim;
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    yayinEviList.value = model.toList();
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            yayinEviList.addAll(data);

            isLoading.value = false;
            yayinEviList.refresh();
          }
          isLoading.value = false;
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yayin Evi Listesi",
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
                    ...yayinEviList.asMap().entries.map((e) => GestureDetector(
                          onTap: () async {
                            if (i == 0) {
                              var d = await Get.put(YayinEviController())
                                  .getEntity("YayinEvi/${e.value.id}");
                              Map<String, dynamic> yayinEvi = {
                                'yayinEviId': e.value.id.toString(),
                                'yayinEviAdi': d.ad
                              };

                              kitapController.girilenVeriler.addAll(yayinEvi);
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
                                  Icons.add_business_rounded,
                                  size: 50,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.value.ad!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: IconButton(
                                          onPressed: () async {
                                            var d = await Get.put(
                                                    YayinEviController())
                                                .getEntity(
                                                    "YayinEvi/${e.value.id}");

                                            Get.to(
                                              YayinEviDetayView(
                                                model: d,
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await Get.put(YayinEviController())
                                              .entityDelete("YayinEvi",
                                                  e.value.id.toString());
                                          Get.put(YayinEviController())
                                              .getAllEntity("YayinEvi")
                                              .then((value) =>
                                                  yayinEviList.value = value);
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove_rounded),
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
            Get.to(AddUpdateYayinEvi());
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
    await Get.put(YayinEviController()).getAllEntityS(
        "YayinEvi?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => yayinEviList.value = value);
  }

  Future<List<ModelYayinEvi>?> _loadMoreData() async {
    temp++;

    if (temp < sayfaSayim!) {
      List<ModelYayinEvi> data =
          await Get.put(YayinEviController()).getAllEntityS(
        "YayinEvi?pageCount=$temp&name=$currentSearchValue",
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
