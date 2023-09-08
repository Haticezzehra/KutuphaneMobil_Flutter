import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/get_token_controller.dart';
import 'package:kutuphane_mobil/Models/model_resim.dart';

class ResimController extends GetxController with EntityMixin<ModelResim> {
  @override
  toJson(ModelResim entity) {
    return entity.toJson();
  }

  @override
  ModelResim fromJson(json) {
    return ModelResim.fromJson(json);
  }
}
