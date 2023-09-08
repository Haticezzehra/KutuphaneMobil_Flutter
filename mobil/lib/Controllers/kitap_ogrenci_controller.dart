import 'package:get/get.dart';

import 'package:kutuphane_mobil/Models/model_kitap_ogrenci.dart';

import 'get_token_controller.dart';

class KitapOgrenciController extends GetxController
    with EntityMixin<ModelKitapOgrenci> {
  Map<String, dynamic> girilenVeriler = {};
  @override
  ModelKitapOgrenci fromJson(json) {
    return ModelKitapOgrenci.fromJson(json);
  }

  void verileriSakla(Map<String, dynamic> veriler) {
    girilenVeriler = veriler;
  }

  @override
  toJson(ModelKitapOgrenci entity) {
    return entity.toJson();
  }

  // Future<List<ModelKitapOgrenci>> getAllEntity(String path) async {
  //   final response = await ClientHelper.client.get(
  //     Uri.parse(ClientHelper.baseUrl + path),
  //     headers: {'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'},
  //   );
  //   final List<dynamic> responseData = json.decode(response.body);
  //   List<ModelKitapOgrenci> resultList =
  //       responseData.map((item) => ModelKitapOgrenci.fromJson(item)).toList();
  //   print(resultList);
  //   return resultList;
  // }

  // ////getEntity
  // Future<ModelKitapOgrenci> getEntity(String path) async {
  //   final response = await ClientHelper.client
  //       .get(Uri.parse(ClientHelper.baseUrl + path), headers: {
  //     'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //   });
  //   //
  //   final dynamic responseData = json.decode(response.body);
  //   ModelKitapOgrenci result = ModelKitapOgrenci.fromJson(responseData);
  //   print(result);
  //   return result;
  // }

  // //Delete Entity
  // static Future<void> entityDelete(String path, String id) async {
  //   await ClientHelper.client
  //       .delete(Uri.parse("${ClientHelper.baseUrl}$path/$id"), headers: {
  //     'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //   });
  // }
}
