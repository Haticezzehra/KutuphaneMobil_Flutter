import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_kullanici.dart';

import 'get_token_controller.dart';

class KullaniciController extends GetxController
    with EntityMixin<ModelKullanici> {
  @override
  ModelKullanici fromJson(json) {
    return ModelKullanici.fromJson(json);
  }

  @override
  toJson(ModelKullanici entity) {
    return entity.toJson();
  }
}
