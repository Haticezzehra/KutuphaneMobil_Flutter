import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/get_token_controller.dart';

import '../Models/model_yazar.dart';

class YazarController extends GetxController with EntityMixin<ModelYazar> {
  @override
  ModelYazar fromJson(json) {
    return ModelYazar.fromJson(json);
  }

  @override
  toJson(ModelYazar entity) {
    return entity.toJson();
  }
}
