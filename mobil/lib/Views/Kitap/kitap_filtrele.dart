import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Controllers/kitap_turu_controller.dart';
import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';

//ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer(
      {super.key,
      required this.kitapList,
      this.sayfaSayim,
      required this.selectedKitapTuru,
      required this.selectedYayinEvi,
      required this.selectedYazar,
      this.temp});
  RxInt? temp = 0.obs;
  var kitapList = <ModelKitap>[].obs;
  RxInt? sayfaSayim;
  var selectedKitapTuru = <String>[].obs;
  var selectedYazar = <String>[].obs;
  var selectedYayinEvi = <String>[].obs;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: PageViewContents(
          selectedYayinEvi: selectedYayinEvi,
          selectedYazar: selectedYazar,
          kitapList: kitapList,
          sayfaSayim: sayfaSayim,
          selectedKitapTuru: selectedKitapTuru,
          temp: temp),
    );
  }
}

//ignore: must_be_immutable
class PageViewContents extends StatelessWidget {
  PageViewContents(
      {super.key,
      required this.kitapList,
      this.sayfaSayim,
      required this.selectedKitapTuru,
      required this.selectedYayinEvi,
      required this.selectedYazar,
      this.temp});
  RxInt? temp = 0.obs;
  RxInt? sayfaSayim;
  var kitapList = <ModelKitap>[].obs;
  int pageCount = 0;
  int? pageCount2;
  final PageController _controller = PageController(initialPage: 0);
  var dataKitapTuru = <ModelKitapTuru>[].obs;
  var dataYayinEvi = <ModelYayinEvi>[].obs;
  var dataYazar = <ModelYazar>[].obs;
  var selectedKitapTuru = <String>[].obs;
  var selectedYazar = <String>[].obs;
  var selectedYayinEvi = <String>[].obs;
  int myIndex = 0;

  void _onChangePage(
    int index,
  ) async {
    myIndex = index;
    _controller.animateToPage(
      myIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Genel(
            kitapList: kitapList,
            dataKitapTuru: dataKitapTuru,
            selectedDataKitapTuru: selectedKitapTuru,
            selectedDataYazar: selectedYazar,
            selectedDataYayinEvi: selectedYayinEvi,
            dataYayinEvi: dataYayinEvi,
            dataYazar: dataYazar,
            kitapTuru: () => _onChangePage(1),
            yayinEvi: () => _onChangePage(2),
            yazar: () => _onChangePage(3),
            sayfaSayim: sayfaSayim,
            temp: temp),
        KitapTuru(
            goBack: () => _onChangePage(0),
            kitapTuruList: dataKitapTuru,
            selectedItems: selectedKitapTuru),
        YayinEvi(
            goBack: () => _onChangePage(0),
            yayinEviList: dataYayinEvi,
            selectedItems: selectedYayinEvi),
        Yazar(
            goBack: () => _onChangePage(0),
            yazarList: dataYazar,
            selectedItems: selectedYazar),
      ],
    );
  }
}

//ignore: must_be_immutable
class Genel extends StatelessWidget {
  Genel(
      {super.key,
      required this.kitapTuru,
      required this.yayinEvi,
      required this.dataKitapTuru,
      required this.yazar,
      required this.selectedDataKitapTuru,
      required this.selectedDataYazar,
      required this.selectedDataYayinEvi,
      required this.kitapList,
      required this.dataYayinEvi,
      required this.dataYazar,
      this.sayfaSayim,
      this.temp});
  var kitapList = <ModelKitap>[].obs;
  RxInt? temp = 0.obs;
  RxInt? sayfaSayim;
  final VoidCallback kitapTuru;
  final VoidCallback yayinEvi;
  final VoidCallback yazar;
  int? pageCount2;
  var selectedDataKitapTuru = <String>[].obs;
  var selectedDataYazar = <String>[].obs;
  var selectedDataYayinEvi = <String>[].obs;
  var dataKitapTuru = <ModelKitapTuru>[].obs;
  var dataYayinEvi = <ModelYayinEvi>[].obs;
  var dataYazar = <ModelYazar>[].obs;
  int? pageCount;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      ListTile(
        title: const Text('Kitap Türü'),
        subtitle: Text("${selectedDataKitapTuru.take(3)}"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          kitapTuru();
          await Get.put(KitapTuruController())
              .getAllEntityS("KitapTuru?sayfasiz=1", func: (sayfaSayisi) {
            pageCount2 = sayfaSayisi!;
          }).then((value) => dataKitapTuru.value = value);
        },
      ),
      const Divider(
        color: Colors.grey,
        thickness: 1,
      ),
      ListTile(
        title: const Text('Yayin Evi'),
        subtitle: Text("${selectedDataYayinEvi.take(3)}"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          yayinEvi();
          await Get.put(YayinEviController())
              .getAllEntityS("YayinEvi?sayfasiz=1", func: (sayfaSayisi) {
            pageCount2 = sayfaSayisi!;
          }).then((value) => dataYayinEvi.value = value);
        },
      ),
      const Divider(
        color: Colors.grey,
        thickness: 1,
      ),
      ListTile(
        title: const Text('Yazar'),
        subtitle: Text("${selectedDataYazar.take(3)}"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          yazar();
          await Get.put(YazarController()).getAllEntityS("Yazar?sayfasiz=1",
              func: (sayfaSayisi) {
            pageCount2 = sayfaSayisi!;
          }).then((value) => dataYazar.value = value);
        },
      ),
      const Divider(
        color: Colors.grey,
        thickness: 1,
      ),
      Row(
        children: [
          TextButton(
              onPressed: () async {
                await Get.put(KitapController())
                    .getAllEntityS("Kitap?pageCount=0", func: (sayfaSayisi) {
                      sayfaSayim?.value = sayfaSayisi!.toInt();
                    })
                    .then((value) => kitapList.value = value)
                    .then((value) => temp = 0.obs)
                    .then((value) => selectedDataKitapTuru.clear())
                    .then((value) => selectedDataYazar.clear())
                    .then((value) => selectedDataYayinEvi.clear());
                Get.back();
              },
              child: const Text("Temizle")),
          TextButton(
              onPressed: () async {
                await Get.put(KitapController())
                    .getAllEntityS(
                        "Kitap?pageCount=0&kitapTuru=$selectedDataKitapTuru&yazar=$selectedDataYazar&yayinEvi=$selectedDataYayinEvi",
                        func: (sayfaSayisi) {
                      sayfaSayim?.value = sayfaSayisi!.toInt();
                    })
                    .then((value) => kitapList.value = value)
                    .then((value) => temp = 0.obs);

                Get.back();
              },
              child: const Text("Filtrele"))
        ],
      )
    ]));
  }
}

//ignore: must_be_immutable
class KitapTuru extends StatelessWidget {
  KitapTuru(
      {super.key,
      required this.goBack,
      required this.kitapTuruList,
      required this.selectedItems});
  int? sayfaSayim;
  final RxBool isLoading = false.obs;
  final VoidCallback goBack;
  var model = <ModelKitapTuru>[].obs;
  var kitapTuruList = <ModelKitapTuru>[].obs;
  var selectedItems = <String>[].obs;

  int temp = 0;
  void handleCheckboxChange(String value, bool isChecked) {
    if (isChecked == true) {
      selectedItems.add(value);
    } else {
      selectedItems.remove(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    kitapTuruList.value = model.toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(), // Yükleme animasyonu
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.arrow_back_ios),
                        title: const Text('Kitap Türü'),
                        onTap: goBack,
                      ),
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
                      ...kitapTuruList
                          .asMap()
                          .entries
                          .map((e) => GestureDetector(
                                child: Row(
                                  children: [
                                    Text(e.value.adi ?? ""),
                                    Checkbox(
                                      value:
                                          selectedItems.contains(e.value.adi),
                                      onChanged: (value) => {
                                        handleCheckboxChange(
                                            e.value.adi ?? "", value ?? false)
                                      },
                                    )
                                  ],
                                ),
                              )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _onSearch(value) async {
    await Get.put(KitapTuruController()).getAllEntityS("KitapTuru?name=$value",
        func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => kitapTuruList.value = value);
  }
}

//ignore: must_be_immutable
class Yazar extends StatelessWidget {
  Yazar(
      {super.key,
      required this.goBack,
      required this.yazarList,
      required this.selectedItems});
  final VoidCallback goBack;

  int? sayfaSayim;
  final RxBool isLoading = false.obs;
  var model = <ModelYazar>[].obs;
  var yazarList = <ModelYazar>[].obs;
  var selectedItems = <String>[].obs;

  int temp = 0;
  void handleCheckboxChange(String value, bool isChecked) {
    if (isChecked == true) {
      selectedItems.add(value);
    } else {
      selectedItems.remove(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    yazarList.value = model.toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(), // Yükleme animasyonu
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.arrow_back_ios),
                        title: const Text('Yazar'),
                        onTap: goBack,
                      ),
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
                      ...yazarList.asMap().entries.map((e) => GestureDetector(
                            child: Row(
                              children: [
                                Text(e.value.adSoyad ?? ""),
                                Checkbox(
                                  value:
                                      selectedItems.contains(e.value.adSoyad),
                                  onChanged: (value) => {
                                    handleCheckboxChange(
                                        e.value.adSoyad ?? "", value ?? false)
                                  },
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _onSearch(value) async {
    await Get.put(YazarController()).getAllEntityS("Yazar?name=$value",
        func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => yazarList.value = value);
  }
}

//ignore: must_be_immutable
class YayinEvi extends StatelessWidget {
  YayinEvi(
      {super.key,
      required this.goBack,
      required this.yayinEviList,
      required this.selectedItems});
  final VoidCallback goBack;

  int? sayfaSayim;
  final RxBool isLoading = false.obs;
  List<ModelYayinEvi>? model;
  var yayinEviList = <ModelYayinEvi>[].obs;
  var selectedItems = <String>[].obs;
  int temp = 0;
  void handleCheckboxChange(String value, bool isChecked) {
    if (isChecked == true) {
      selectedItems.add(value);
    } else {
      selectedItems.remove(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    yayinEviList.value = model?.toList() ?? [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(), // Yükleme animasyonu
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.arrow_back_ios),
                        title: const Text('Yayin Evi'),
                        onTap: goBack,
                      ),
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
                      ...yayinEviList
                          .asMap()
                          .entries
                          .map((e) => GestureDetector(
                                child: Row(
                                  children: [
                                    Text(e.value.ad ?? ""),
                                    Checkbox(
                                      value: selectedItems.contains(e.value.ad),
                                      onChanged: (value) => {
                                        handleCheckboxChange(
                                            e.value.ad ?? "", value ?? false)
                                      },
                                    )
                                  ],
                                ),
                              )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _onSearch(value) async {
    await Get.put(YayinEviController())
        .getAllEntityS("YayinEvi?name=$value&sayfasiz=1", func: (sayfaSayisi) {
      sayfaSayim = sayfaSayisi;
    }).then((value) => yayinEviList.value = value);
  }
}
