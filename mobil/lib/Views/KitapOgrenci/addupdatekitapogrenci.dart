import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Controllers/kullanici_controller.dart';
import 'package:kutuphane_mobil/Controllers/ogrenci_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_kitap_ogrenci.dart';
import 'package:kutuphane_mobil/Models/model_kullanici.dart';
import 'package:kutuphane_mobil/Models/model_ogrenci.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitapview.dart';
import 'package:kutuphane_mobil/Views/Kullanici/kullanici_view.dart';
import 'package:kutuphane_mobil/Views/Ogrenci/ogrenciview.dart';
import '../../Controllers/kitap_ogrenci_controller.dart';

//ignore: must_be_immutable
class AddUpdateKitapOgrenci extends StatelessWidget {
  AddUpdateKitapOgrenci({super.key, this.model});
  final KitapOgrenciController kitapOgrenciController =
      Get.find<KitapOgrenciController>();
  var filtreli = 0.obs;
  final ModelKitapOgrenci? model;
  final ogrenciList = <ModelOgrenci>[].obs;
  final kitapList = <ModelKitap>[].obs;
  final TextEditingController kitapAdiController =
      TextEditingController(text: "");
  final TextEditingController ogrenciAdiController =
      TextEditingController(text: "");
  final TextEditingController kullaniciAdiController =
      TextEditingController(text: "");
  final TextEditingController idController = TextEditingController(text: "");
  final TextEditingController alisTarihiController =
      TextEditingController(text: "");
  final TextEditingController teslimTarihiController =
      TextEditingController(text: "");

  final TextEditingController kullaniciIdController =
      TextEditingController(text: "");
  final TextEditingController kitapIdController =
      TextEditingController(text: "");
  final TextEditingController ogrenciIdController =
      TextEditingController(text: "");
  final selectedOgrenci = Rxn<ModelOgrenci>(null);
  final selectedKitap = Rxn<ModelKitap>(null);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(2023, 09, 01);
    Get.put(KitapController())
        .getAllEntity("Kitap")
        .then((value) => kitapList.value = value);
    Get.put(OgrenciController())
        .getAllEntity("Ogrenci")
        .then((value) => ogrenciList.value = value);

    String? buttonText;
    if (model?.id != null) {
      kitapAdiController.text = model!.kitapAdi.toString();
      buttonText = "Güncelle";
      idController.text = model!.id.toString();
      ogrenciAdiController.text = model!.ogrenciAd.toString();
      kullaniciAdiController.text = model!.kullaniciAdi.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Kayıt"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment:
                  Alignment.centerRight, // İkonun sağda olmasını isterseniz
              children: [
                TextField(
                  controller: kitapAdiController,
                  decoration: const InputDecoration(labelText: "Kitap Adi:"),
                ),
                Positioned(
                  right: 8, // İkonun sağdan uzaklığını ayarlayın
                  child: IconButton(
                    onPressed: () async {
                      Map<String, dynamic> myVeriler = {
                        'kitapAdi': kitapAdiController.text,
                        'OgrenciAdi': ogrenciAdiController.text,
                        'KullaniciAdi': kullaniciAdiController.text,
                        'KullaniciId': kullaniciIdController.text,
                        'OgrenciId': ogrenciIdController.text,
                        'KitapId': kitapIdController.text
                      };
                      kitapOgrenciController.verileriSakla(myVeriler);
                      List<ModelKitap> data = await Get.put(KitapController())
                          .getAllEntityS("Kitap?pageCount=0",
                              func: (sayfaSayisi) {
                        filtreli.value = sayfaSayisi!;
                      });
                      final args = await Get.to(KitapView(
                        model: data,
                        i: 0,
                        sayfaSayim: filtreli,
                      ));

                      if (args != null) {
                        kitapOgrenciController.girilenVeriler = args;
                        geriDonusIslemleri();
                        // Diğer verileri burada güncelleyebilirsiniz...
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: kullaniciAdiController,
                  decoration:
                      const InputDecoration(labelText: "Kullanıcı Adı:"),
                ),
                Positioned(
                  right: 8, // İkonun sağdan uzaklığını ayarlayın
                  child: IconButton(
                    onPressed: () async {
                      Map<String, dynamic> myVeriler = {
                        'kitapAdi': kitapAdiController.text,
                        'OgrenciAdi': ogrenciAdiController.text,
                        'KullaniciAdi': kullaniciAdiController.text,
                        'KullaniciId': kullaniciIdController.text,
                        'OgrenciId': ogrenciIdController.text,
                        'KitapId': kitapIdController.text
                      };

                      kitapOgrenciController.verileriSakla(myVeriler);
                      List<ModelKullanici> data =
                          await Get.put(KullaniciController()).getAllEntityS(
                              "Kullanici?pageCount=0", func: (sayfaSayisi) {
                        filtreli.value = sayfaSayisi!;
                      });
                      final args = await Get.to(KullaniciView(model: data));
                      if (args != null) {
                        kitapOgrenciController.girilenVeriler = args;
                        geriDonusIslemleri();
                        // Diğer verileri burada güncelleyebilirsiniz...
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: ogrenciAdiController,
                  decoration: const InputDecoration(labelText: "Öğrenci Adı:"),
                ),
                Positioned(
                  right: 8, // İkonun sağdan uzaklığını ayarlayın
                  child: IconButton(
                    onPressed: () async {
                      Map<String, dynamic> myVeriler = {
                        'kitapAdi': kitapAdiController.text,
                        'OgrenciAdi': ogrenciAdiController.text,
                        'KullaniciAdi': kullaniciAdiController.text,
                        'KullaniciId': kullaniciIdController.text,
                        'OgrenciId': ogrenciIdController.text,
                        'KitapId': kitapIdController.text
                      };
                      kitapOgrenciController.verileriSakla(myVeriler);
                      List<ModelOgrenci> data =
                          await Get.put(OgrenciController()).getAllEntityS(
                              "Ogrenci?pageCount=0", func: (sayfaSayisi) {
                        filtreli.value = sayfaSayisi!;
                      });
                      final args = await Get.to(OgrenciView(
                        model: data,
                        i: 0,
                      ));
                      if (args != null) {
                        kitapOgrenciController.girilenVeriler = args;
                        geriDonusIslemleri();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),

            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: alisTarihiController,
                  decoration: const InputDecoration(labelText: "Alış Tarihi:"),
                ),
                Positioned(
                  right: 8, // İkonun sağdan uzaklığını ayarlayın
                  child: IconButton(
                    onPressed: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      alisTarihiController.text = dateTime.toString();
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: teslimTarihiController,
                  decoration:
                      const InputDecoration(labelText: "Teslim Tarihi:"),
                ),
                Positioned(
                  right: 8, // İkonun sağdan uzaklığını ayarlayın
                  child: IconButton(
                    onPressed: () async {
                      DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      teslimTarihiController.text = dateTime.toString();
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ),
              ],
            ),

            ///

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 80),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
              onPressed: () async {
                ModelKitapOgrenci kitapOgrenci = ModelKitapOgrenci(
                    id: int.parse(idController.text),
                    kitapAdi: kitapAdiController.text,
                    ogrenciAd: ogrenciAdiController.text,
                    kullaniciAdi: kullaniciAdiController.text,
                    alisTarihi: alisTarihiController.text,
                    teslimTarihi: teslimTarihiController.text,
                    kitapId: int.parse(kitapIdController.text),
                    kullaniciId: int.parse(kullaniciIdController.text),
                    ogrenciId: int.parse(ogrenciIdController.text));
                if (buttonText == "Güncelle") {
                  await Get.put(KitapOgrenciController()).entityUpdate(
                      "KitapOgrenci", kitapOgrenci.id.toString(), kitapOgrenci);
                } else {
                  await Get.put(KitapOgrenciController())
                      .postEntity("KitapOgrenci", kitapOgrenci);
                }
                //entity add

                //
              },
              child: Text(buttonText ?? "Kitap Öğrenci Ekle"),
            )
          ],
        ),
      ),
    );
  }

  void verileriSakla(Map<String, dynamic> veriler) {
    kitapOgrenciController.girilenVeriler = veriler;
  }

  void geriDonusIslemleri() {
    kitapAdiController.text =
        kitapOgrenciController.girilenVeriler['kitapAdi'] ?? "";
    kullaniciAdiController.text =
        kitapOgrenciController.girilenVeriler['KullaniciAdi'] ?? "";
    ogrenciAdiController.text =
        kitapOgrenciController.girilenVeriler['OgrenciAdi'] ?? "";
    kitapIdController.text =
        kitapOgrenciController.girilenVeriler['KitapId'] ?? "";
    ogrenciIdController.text =
        kitapOgrenciController.girilenVeriler['OgrenciId'] ?? "";
    kullaniciIdController.text =
        kitapOgrenciController.girilenVeriler['KullaniciId'] ?? "";
  }
}
