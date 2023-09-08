import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_ogrenci.dart';

import 'get_token_controller.dart';

class OgrenciController extends GetxController with EntityMixin<ModelOgrenci> {
  @override
  ModelOgrenci fromJson(json) {
    return ModelOgrenci.fromJson(json);
  }

  @override
  toJson(ModelOgrenci entity) {
    return entity.toJson();
  }
}
