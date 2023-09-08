import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_ogrenci_controller.dart';
import 'package:kutuphane_mobil/Controllers/kullanici_controller.dart';
import 'package:kutuphane_mobil/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';
import 'package:kutuphane_mobil/Models/model_kullanici.dart';
import 'package:kutuphane_mobil/Models/model_ogrenci.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitapview.dart';
import 'package:kutuphane_mobil/Views/KitapOgrenci/kitapogrenciview.dart';
import 'package:kutuphane_mobil/Views/KitapTuru/kitapturuview.dart';
import 'package:kutuphane_mobil/Views/Kullanici/kullanici_view.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/yayineviview.dart';
import 'package:kutuphane_mobil/Views/Yazar/yazarview.dart';
import '../Controllers/kitap_controller.dart';
import '../Controllers/kitap_turu_controller.dart';
import '../Models/model_kitap_ogrenci.dart';
import 'Ogrenci/ogrenciview.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    int? pageCount;
    var filtreli = 0.obs;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Anasayfa",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: const BoxDecoration(),
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Column(children: [
                                  IconButton(
                                    onPressed: () async {
                                      List<ModelKitap> data =
                                          await Get.put(KitapController())
                                              .getAllEntityS(
                                                  "Kitap?pageCount=0",
                                                  func: (sayfaSayisi) {
                                        filtreli.value = sayfaSayisi!;
                                      });

                                      Get.to(
                                        KitapView(
                                          model: data,
                                          sayfaSayim: filtreli,
                                        ),
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.auto_stories_sharp,
                                      size: 100,
                                    ),

                                    // child: const Text("Kitap Listele"),
                                  ),
                                  const Text(
                                    "Kitap",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      List<ModelYayinEvi> data =
                                          await Get.put(YayinEviController())
                                              .getAllEntityS(
                                        "YayinEvi?pageCount=0",
                                        func: (sayfaSayisi) {
                                          pageCount = sayfaSayisi;
                                        },
                                      );
                                      Get.to(Get.to(YayinEviView(
                                        model: data,
                                        sayfaSayim: pageCount,
                                      )));
                                    },
                                    icon: const Icon(
                                      Icons.add_business_rounded,
                                      size: 100,
                                    ),
                                  ),
                                  const Text(
                                    "YayinEvi",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(children: [
                                IconButton(
                                  onPressed: () async {
                                    List<ModelKitapOgrenci> data =
                                        await Get.put(KitapOgrenciController())
                                            .getAllEntityS(
                                      "KitapOgrenci?pageCount=0",
                                      func: (sayfaSayisi) {
                                        pageCount = sayfaSayisi;
                                      },
                                    );

                                    Get.to(KitapOgrenciView(
                                      model: data,
                                      sayfaSayim: pageCount,
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.save_as,
                                    size: 100,
                                  ),
                                ),
                                const Text(
                                  "Kitap Öğrenci Kayıt",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(children: [
                                IconButton(
                                  onPressed: () async {
                                    List<ModelOgrenci> data =
                                        await Get.put(OgrenciController())
                                            .getAllEntityS(
                                      "Ogrenci",
                                      func: (sayfaSayisi) {
                                        pageCount = sayfaSayisi;
                                      },
                                    );
                                    Get.to(OgrenciView(
                                        model: data, sayfaSayim: pageCount));
                                  },
                                  icon: const Icon(
                                    Icons.person,
                                    size: 100,
                                  ),
                                ),
                                const Text(
                                  "Öğrenci",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(children: [
                                IconButton(
                                  onPressed: () async {
                                    List<ModelYazar> data =
                                        await Get.put(YazarController())
                                            .getAllEntityS(
                                      "Yazar?pageCount=0",
                                      func: (sayfaSayisi) {
                                        pageCount = sayfaSayisi;
                                      },
                                    );
                                    Get.to(YazarView(
                                      model: data,
                                      sayfaSayim: pageCount,
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.person_outline_rounded,
                                    size: 100,
                                    // color: Colors.blueAccent[],
                                  ),
                                ),
                                const Text(
                                  "Yazar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Column(children: [
                                IconButton(
                                  onPressed: () async {
                                    List<ModelKitapTuru> data =
                                        await Get.put(KitapTuruController())
                                            .getAllEntityS(
                                      "KitapTuru?pageCount=0",
                                      func: (sayfaSayisi) {
                                        pageCount = sayfaSayisi;
                                      },
                                    );

                                    Get.to(KitapTuruView(
                                        model: data, sayfaSayim: pageCount));
                                  },
                                  icon: const Icon(
                                    Icons.adobe_rounded,
                                    size: 100,
                                  ),
                                ),
                                const Text(
                                  "Kitap Türü",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: Column(children: [
                          IconButton(
                            onPressed: () async {
                              List<ModelKullanici> data =
                                  await Get.put(KullaniciController())
                                      .getAllEntityS(
                                "Kullanici",
                                func: (sayfaSayisi) {
                                  pageCount = sayfaSayisi;
                                },
                              );
                              Get.to(
                                KullaniciView(
                                  model: data,
                                  sayfaSayim: pageCount,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.person_2_outlined,
                              size: 100,
                            ),
                          ),
                          const Text(
                            "Kullanıcı",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
