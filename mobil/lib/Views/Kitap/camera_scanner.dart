// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:kutuphane_mobil/Views/Kitap/addupdatekitap.dart';

// //ignore: must_be_immutable
// class RecognizePage extends StatelessWidget {
//   RecognizePage({Key? key, this.path, required this.okunanDeger})
//       : super(key: key);
//   final String? path;
//   final TextEditingController controller = TextEditingController();
//   var okunanDeger = <String>[].obs;

//   Future<void> processImage(InputImage image) async {
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//     log(image.filePath!);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(image);
//     okunanDeger.addAll([recognizedText.text]);
//     // print(okunanDeger);
//     controller.text = recognizedText.text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final InputImage inputImage = InputImage.fromFilePath(path!);

//     return AddUpdateKitap();
//   }
// }
