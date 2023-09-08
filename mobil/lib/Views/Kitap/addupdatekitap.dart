import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutuphane_mobil/Controllers/kitap_controller.dart';
import 'package:kutuphane_mobil/Controllers/kitap_turu_controller.dart';
import 'package:kutuphane_mobil/Controllers/resim_controller.dart';
import 'package:kutuphane_mobil/Controllers/yayinevi_controller.dart';
import 'package:kutuphane_mobil/Controllers/yazar_controller.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';
import 'package:kutuphane_mobil/Models/model_resim.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';
import 'package:kutuphane_mobil/Models/model_yazar.dart';
import 'package:kutuphane_mobil/Views/Kitap/kitap_resim_view.dart';
import 'package:kutuphane_mobil/Views/KitapTuru/kitapturuview.dart';
import 'package:kutuphane_mobil/Views/YayinEvi/yayineviview.dart';
import 'package:kutuphane_mobil/Views/Yazar/yazarview.dart';

//ignore: must_be_immutable
class AddUpdateKitap extends StatelessWidget {
  AddUpdateKitap({super.key, this.model, this.yayinEvi, this.resim});
  final KitapController kitapController = Get.find<KitapController>();
  int? pageCount;
  final ModelKitap? model;
  List<dynamic>? resim = [];
  File? image;
  final ModelYayinEvi? yayinEvi;
  final kitapTurList = <ModelKitapTuru>[].obs;
  final yazarList = <ModelYazar>[].obs;
  final picker = ImagePicker();
  final TextEditingController kitapAdiController = TextEditingController();
  final TextEditingController kitapTurAdiController = TextEditingController();
  final TextEditingController yayineviadiController = TextEditingController();
  final TextEditingController yazarAdiController = TextEditingController();
  final TextEditingController sayfaSayisiController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController kitapTurIdController = TextEditingController();
  final TextEditingController yayinEviIdController = TextEditingController();
  final TextEditingController yazarIdController = TextEditingController();
  final selectedItem = Rxn<ModelYayinEvi>(null);
  final selectedKitapTur = Rxn<ModelKitapTuru>(null);
  final selectedYazar = Rxn<ModelYazar>(null);
  String? base64Image;
  get data => null;
  final box = GetStorage();
  final okunanDeger = <String>[].obs;
  var items = <String>[].obs;
  final selectedOption = Rxn("");

  Future<void> processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);
    var linesList = recognizedText.text.split('\n').toList();
    okunanDeger.clear();
    for (var element in linesList) {
      okunanDeger.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? buttonText;
    if (model?.adi != null) {
      kitapAdiController.text = model!.adi.toString();
      buttonText = "Kitap Güncelle";
      idController.text = model!.id.toString();
      kitapTurAdiController.text = model!.kitapTurAdi.toString();
      yazarAdiController.text = model!.yazarAdi.toString();
      sayfaSayisiController.text = model!.sayfaSayisi.toString();
      yayineviadiController.text = model!.yayinEviAdi.toString();
    } else {
      idController.text = 0.toString();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Kitap İşlemleri"),
        ),
        body: SafeArea(
          child: Column(children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Expanded(
                    child: DropdownMenu<String>(
                      dropdownMenuEntries: [
                        ...okunanDeger.asMap().entries.map(
                              (e) => DropdownMenuEntry(
                                value: kitapAdiController.text = e.value,
                                label: e.value,
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    pickImage(source: ImageSource.camera).then((value) async {
                      if (value != '') {
                        await imageCropperView(value).then((value) async {
                          if (value != '') {
                            await processImage(InputImage.fromFilePath(value));
                          }
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: yayineviadiController,
                    decoration: const InputDecoration(
                        labelText: "Yayin Evi Adi", isDense: true),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Map<String, dynamic> myVeriler = {
                      'kitapAdi': kitapAdiController.text,
                      'sayfaSayisi': sayfaSayisiController.text,
                      'kitapTurAdi': kitapTurAdiController.text,
                      'yayinEviAdi': yayineviadiController.text,
                      'yazarAdi': yazarAdiController.text,
                      'yayinEviId': yayinEviIdController.text,
                      'kitapTurID': kitapTurIdController.text,
                      'yazarId': yazarIdController.text
                    };
                    kitapController.verileriSakla(myVeriler);
                    List<ModelYayinEvi> data =
                        await Get.put(YayinEviController()).getAllEntityS(
                      "YayinEvi?pageCount=0",
                      func: (sayfaSayisi) {
                        pageCount = sayfaSayisi;
                      },
                    );
                    final args = await Get.to(YayinEviView(
                      model: data,
                      sayfaSayim: pageCount,
                    ));
                    if (args != null) {
                      kitapController.girilenVeriler = args;
                      geriDonusIslemleri();
                      // Diğer verileri burada güncelleyebilirsiniz...
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: kitapTurAdiController,
                    decoration: const InputDecoration(
                        labelText: "KitapTur Adi", isDense: true),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Map<String, dynamic> myVeriler = {
                      'kitapAdi': kitapAdiController.text,
                      'sayfaSayisi': sayfaSayisiController.text,
                      'kitapTurAdi': kitapTurAdiController.text,
                      'yayinEviAdi': yayineviadiController.text,
                      'yazarAdi': yazarAdiController.text,
                      'yayinEviId': yayinEviIdController.text,
                      'kitapTurID': kitapTurIdController.text,
                      'yazarId': yazarIdController.text
                    };
                    kitapController.verileriSakla(myVeriler);
                    List<ModelKitapTuru> data =
                        await Get.put(KitapTuruController()).getAllEntityS(
                      "KitapTuru?pageCount=0",
                      func: (sayfaSayisi) {
                        pageCount = sayfaSayisi;
                      },
                    );

                    final args = await Get.to(KitapTuruView(
                      model: data,
                      sayfaSayim: pageCount,
                    ));
                    if (args != null) {
                      kitapController.girilenVeriler = args;
                      geriDonusIslemleri();
                      // Diğer verileri burada güncelleyebilirsiniz...
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: yazarAdiController,
                    decoration: const InputDecoration(
                        labelText: "Yazar Adi ", isDense: true),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Map<String, dynamic> myVeriler = {
                      'kitapAdi': kitapAdiController.text,
                      'sayfaSayisi': sayfaSayisiController.text,
                      'kitapTurAdi': kitapTurAdiController.text,
                      'yayinEviAdi': yayineviadiController.text,
                      'yazarAdi': yazarAdiController.text,
                      'yayinEviId': yayinEviIdController.text,
                      'kitapTurID': kitapTurIdController.text,
                      'yazarId': yazarIdController.text
                    };
                    kitapController.verileriSakla(myVeriler);
                    List<ModelYazar> data =
                        await Get.put(YazarController()).getAllEntityS(
                      "Yazar?pageCount=0",
                      func: (sayfaSayisi) {
                        pageCount = sayfaSayisi;
                      },
                    );
                    final args = await Get.to(
                        YazarView(model: data, sayfaSayim: pageCount));
                    if (args != null) {
                      kitapController.girilenVeriler = args;
                      geriDonusIslemleri();
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: sayfaSayisiController,
                decoration: const InputDecoration(
                    labelText: "Sayfa Sayısı", isDense: true),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                if (image != null) {
                  base64Image = await convertFileToBytes(image!);
                }
                print("KitapaDİ${kitapAdiController.text}");
                ModelKitap kitap = ModelKitap(
                  id: int.parse(idController.text),
                  adi: kitapAdiController.text,
                  sayfaSayisi: int.tryParse(sayfaSayisiController.text) ?? 0,
                  kitapTurAdi: kitapTurAdiController.text,
                  kitapTurId:
                      int.parse(kitapController.girilenVeriler['kitapTurID']),
                  yayinEviAdi: kitapController.girilenVeriler['yayinEviAdi'],
                  yayinEviId:
                      int.parse(kitapController.girilenVeriler['yayinEviId']),
                  yazarId: int.parse(kitapController.girilenVeriler['yazarId']),
                  kayitYapan: box.read('username'),
                );

                if (buttonText == "Kitap Güncelle") {
                  await Get.put(KitapController())
                      .entityUpdate("Kitap", kitap.id.toString(), kitap);
                } else {
                  await Get.put(KitapController()).postEntity("Kitap", kitap);
                }
              },
              child: Text(buttonText ?? "Kitap Ekle"),
            ),
            MaterialButton(
                child: const Text("Resim Ekle"),
                onPressed: () async {
                  List<ModelResim> data =
                      await Get.put(ResimController()).getAllEntity("Resim");

                  Get.to(KitapResimView(
                    model: data,
                    id: model?.id,
                  ));
                }),
          ]),
        ));
  }

  Future<String> convertFileToBytes(File file) async {
    Uint8List imagebytes = await file.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return base64string;
  }

  void verileriSakla(Map<String, dynamic> veriler) {
    kitapController.girilenVeriler = veriler;
  }

  void geriDonusIslemleri() {
    kitapAdiController.text = kitapController.girilenVeriler['kitapAdi'] ?? "";
    yayineviadiController.text =
        kitapController.girilenVeriler['yayinEviAdi'] ?? "";
    sayfaSayisiController.text =
        kitapController.girilenVeriler['sayfaSayisi'] ?? "";
    kitapTurAdiController.text =
        kitapController.girilenVeriler['kitapTurAdi'] ?? "";
    yazarAdiController.text = kitapController.girilenVeriler['yazarAdi'] ?? "";
    yayinEviIdController.text =
        kitapController.girilenVeriler['yayinEviId'] ?? "";
    kitapTurIdController.text =
        kitapController.girilenVeriler['kitapTurID'] ?? "";
    yazarIdController.text = kitapController.girilenVeriler['yazarId'] ?? "";
  }

  Future<String> pickImage({ImageSource? source}) async {
    final picker = ImagePicker();

    String path = '';

    final getImage = await picker.pickImage(source: source!);

    if (getImage != null) {
      path = getImage.path;
    } else {
      path = '';
    }

    return path;
  }

  Future<String> imageCropperView(String? path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedFile != null) {
      return croppedFile.path;
    } else {
      return '';
    }
  }
}
