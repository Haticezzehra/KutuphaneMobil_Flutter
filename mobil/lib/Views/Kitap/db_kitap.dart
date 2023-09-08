import 'package:kutuphane_mobil/Models/model_kitap.dart';
import 'package:kutuphane_mobil/url.dart';

class DBKitap {
  Future<List<ModelKitap>?> kitapLGetir() async {
    var data = await URL.addKitap.getYeni();
    if (data != null) {
      return modelKitapLFromJson(data);
    } else {
      return null;
    }
  }
}
