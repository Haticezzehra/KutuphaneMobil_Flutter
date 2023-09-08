import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:kutuphane_mobil/Controllers/resim_controller.dart';
import 'package:kutuphane_mobil/Models/model_resim.dart';

//ignore: must_be_immutable
class KitapResimView extends StatelessWidget {
  KitapResimView({super.key, this.model, this.id});
  XFile? image;
  final picker = ImagePicker();
  final List<ModelResim>? model;
  final resimList = <ModelResim>[].obs;
  final int? id;
  final List<XFile> resultList = [];
  @override
  Widget build(BuildContext context) {
    if (model != null) {
      resimList.value = model!.where((item) => item.kitapId == id).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resim İşlemleri"),
      ),
      body: Obx(
        () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Üç resim yan yana sıralanacak
            crossAxisSpacing: 5.0, // Yatay boşluk
            mainAxisSpacing: 5.0, // Dikey boşluk
          ),
          itemCount: resimList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(5),
              height: 200,
              child: Stack(
                children: [
                  Center(
                    child:
                        buildImageFromByte(resimList[index].resim1.toString()),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await Get.put(ResimController().entityDelete(
                            "Resim", resimList[index].id.toString()));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        MaterialButton(
          child: const Text("Fotoğraf Çek"),
          onPressed: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              final img = await convertFileToBytes(XFile(pickedFile.path));
              resimEkle(img);
            }
          },
        ),
        MaterialButton(
          child: const Text("Fotoğraf Seç"),
          onPressed: () async {
            final List<XFile> result = await picker.pickMultiImage();
            resultList.addAll(result);
            for (XFile x in resultList) {
              final img = await convertFileToBytes(XFile(x.path));
              resimEkle(img);
            }
          },
        ),
      ],
    );
  }

  Future<void> resimEkle(String resim) async {
    ModelResim res = ModelResim(resim1: resim, kitapId: id, id: 1);
    await Get.put(ResimController()).postEntity("Resim", res);
  }

  Future<String> convertFileToBytes(XFile file) async {
    Uint8List imagebytes = await file.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return base64string;
  }

  Widget buildImageFromByte(String baseString) {
    // Byte dizisinin base64 kodlaması
    Uint8List bytes = base64Decode(baseString);
    return Image.memory(
      errorBuilder: (context, error, stackTrace) {
        return const Text("Resim Yok");
      },
      bytes,
      width: 100,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}
