import 'package:http/http.dart' as http;
import 'package:kutuphane_mobil/Models/token_model.dart';

import 'package:get/get.dart';

class UrlControllerController extends GetxController {
  final _kullaniciAdi = ''.obs;
  String get kullaniciAdi => _kullaniciAdi.value;
  set kullaniciAdi(String value) => _kullaniciAdi.value = value;

  final _sifre = ''.obs;
  String get sifre => _sifre.value;
  set sifre(String value) => _sifre.value = value;
}

enum URL {
  getAllKitap,
  addKitap,
}

extension UrlExtension on URL {
  static Future<TokenModel> _getToken() async {
    const serviceUrl = "http://192.168.1.177/token";
    final data = {
      'grant_type': 'password',
      'username': Get.put(UrlControllerController()).kullaniciAdi,
      'password': Get.put(UrlControllerController()).sifre,
    };

    final response = await http.post(Uri.parse(serviceUrl), body: data);
    var token = tokenModelFromJson(response.body);

    return token;
  }

  static const _url = "http://192.168.1.177/api/";
  Future<String?> getYeni({String urlEk = ""}) async {
    var token = await _getToken();
    var data = await http.get(
      Uri.parse(_url + name + urlEk),
      headers: {
        "Bearer": token.accessToken ?? "",
      },
    );
    if (data.statusCode == 200) {
      return data.body;
    } else if (data.statusCode == 404) {
      // print("bulunamadı hatası");
      return null;
    } else {
      // print(jsonDecode(data.body)["Message"]);
      return null;
    }
  }

  Future<String?> postYeni({required Object body, String urlEk = ""}) async {
    var token = await _getToken();
    var data = await http.post(
      Uri.parse(_url + name + urlEk),
      headers: {
        "Bearer": token.accessToken ?? "",
      },
      body: body,
    );
    if (data.statusCode == 200) {
      return data.body;
    } else if (data.statusCode == 404) {
      //print("bulunamadı hatası");
      return null;
    } else {
      //print(jsonDecode(data.body)["Message"]);
      return null;
    }
  }
}
