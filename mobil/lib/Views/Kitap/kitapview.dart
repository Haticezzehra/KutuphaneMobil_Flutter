import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_resim.dart';
import 'package:kutuphane_mobil/Views/Kitap/addupdatekitap.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitap_filtrele.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitapdetayview.dart';

//ignore: must_be_immutable
class KitapView extends StatelessWidget {
  KitapView({
    super.key,
    required this.model,
    required this.sayfaSayim,
    this.i,
    this.resimmodel,
  });
  final KitapController kitapController = Get.put(KitapController());
  final ScrollController _scrollController = ScrollController();

  final kitap = ModelKitap();
  int sdegis = 0;
  List<ModelKitap> model;
  final kitapList = <ModelKitap>[].obs;
  RxInt? temp = 0.obs;
  String currentSearchValue = "";
  final RxBool isLoading = false.obs;
  var sayfaSayim = 0.obs;
  int? i = 0;
  List<ModelResim>? resimmodel;
  final resimList = <ModelResim>[].obs;
  var selectedKitapTuru = <String>[].obs;
  var selectedYazar = <String>[].obs;
  var selectedYayinEvi = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    kitapList.value = model.toList();
    kitapList.refresh();

    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0.0) {
          isLoading.value = true;
          var data = await _loadMoreData();

          if (data != null) {
            kitapList.addAll(data);

            isLoading.value = false;
            kitapList.refresh();
          }
          isLoading.value = false;
        }
      }
    });
    return scafoldWidget(context);
  }

  Scaffold scafoldWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kitap Listesi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      endDrawer: MyDrawer(
        selectedKitapTuru: selectedKitapTuru,
        selectedYayinEvi: selectedYayinEvi,
        selectedYazar: selectedYazar,
        kitapList: kitapList,
        sayfaSayim: sayfaSayim,
        temp: temp,
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
                    SearchBar(
                      onChanged: _onSearch,
                      leading: const Icon(Icons.search),
                    ),
                    ...kitapList.asMap().entries.map((e) => GestureDetector(
                          onTap: () async {
                            if (i == 0) {
                              var d = await Get.put(KitapController())
                                  .getEntity("Kitap/${e.value.id}");
                              Map<String, dynamic> yayinEvi = {
                                'KitapId': e.value.id.toString(),
                                'kitapAdi': d.adi
                              };

                              if (resimmodel != null) {
                                resimList.value = resimmodel!
                                    .where((item) => item.kitapId == e.value.id)
                                    .toList();
                              }
                              kitapController.girilenVeriler.addAll(yayinEvi);
                              Map<String, dynamic> args =
                                  kitapController.girilenVeriler;
                              Get.back(result: args);
                            }
                            if (i == 1) {
                              var d = await Get.put(KitapController())
                                  .getEntity("Kitap/${e.value.id}");

                              Get.to(
                                KitapDetayView(
                                  model: d,
                                ),
                              );
                            }
                          },
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Düğmeleri en sağa hizala
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: resimList.isEmpty
                                              ? const Icon(
                                                  Icons.auto_stories_sharp,
                                                  size: 50,
                                                )
                                              : buildImageFromByte(resimList[0]
                                                  .resim1
                                                  .toString()),
                                        ),
                                      ]),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(e.value.adi ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Yazar:${e.value.yazarAdi ?? ""}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            var d =
                                                await Get.put(KitapController())
                                                    .getEntity(
                                                        "Kitap/${e.value.id}");

                                            Get.to(
                                              KitapDetayView(
                                                model: d,
                                                resimmodel: resimmodel,
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await Get.put(KitapController())
                                                .entityDelete("Kitap",
                                                    e.value.id.toString());
                                            Get.put(KitapController())
                                                .getAllEntity("Kitap")
                                                .then((value) =>
                                                    kitapList.value = value);
                                          },
                                          icon: const Icon(
                                              Icons.highlight_remove_rounded),
                                        ),
                                      ])
                                ],
                              ),
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
            Get.to(AddUpdateKitap());
          },
          icon: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ],
    );
  }

  void _onSearch(value) async {
    temp = 0.obs;
    currentSearchValue = value;
    await Get.put(KitapController()).getAllEntityS(
        "Kitap?name=$value&pageCount=$temp", func: (sayfaSayisi) {
      sayfaSayim = RxInt(sayfaSayisi!);
    }).then((value) => kitapList.value = value);
  }

  Future<List<ModelKitap>?> _loadMoreData() async {
    temp != temp! + 1;

    if (temp! < sayfaSayim.value) {
      List<ModelKitap> data = await Get.put(KitapController()).getAllEntityS(
        "Kitap?pageCount=$temp&name=$currentSearchValue&kitapTuru=$selectedKitapTuru&yazar=$selectedYazar&yayinEvi=$selectedYayinEvi",
        func: (sayfaSayisi) {
          sayfaSayim = RxInt(sayfaSayisi!);
        },
      );

      return data;
    } else {
      return null;
    }
  }

  Widget buildImageFromByte(String baseString) {
    // Byte dizisinin base64 kodlaması
    Uint8List bytes = base64Decode(baseString);
    return Image.memory(
      errorBuilder: (context, error, stackTrace) {
        return const Text("Resim Yok");
      },
      bytes,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}
