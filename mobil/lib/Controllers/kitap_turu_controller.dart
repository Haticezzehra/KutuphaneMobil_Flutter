import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_kitap_turu.dart';

import 'get_token_controller.dart';

class KitapTuruController extends GetxController
    with EntityMixin<ModelKitapTuru> {
  @override
  ModelKitapTuru fromJson(json) {
    return ModelKitapTuru.fromJson(json);
  }

  @override
  toJson(ModelKitapTuru entity) {
    return entity.toJson();
  }
}
