import 'package:get/get.dart';
import 'package:kutuphane_mobil/Models/model_kitap.dart';

import 'get_token_controller.dart';

class KitapController extends GetxController with EntityMixin<ModelKitap> {
  Map<String, dynamic> girilenVeriler = {};
  final kitapList = <ModelKitap>[].obs;
  @override
  ModelKitap fromJson(json) {
    return ModelKitap.fromJson(json);
  }

  //verileri saklama
  void verileriSakla(Map<String, dynamic> veriler) {
    girilenVeriler = veriler;
  }

  @override
  toJson(ModelKitap entity) {
    return entity.toJson();
  }

  // Future<List<ModelKitap>> getAllEntity(String path) async {
  //   final response = await ClientHelper.client.get(
  //     Uri.parse(ClientHelper.baseUrl + path),
  //     headers: {'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'},
  //   );
  //   final List<dynamic> responseData = json.decode(response.body);
  //   List<ModelKitap> resultList =
  //       responseData.map((item) => ModelKitap.fromJson(item)).toList();
  //   //print(resultList);
  //   return resultList;
  // }

  // ////getEntity
  // Future<ModelKitap> getEntity(String path) async {
  //   final response = await ClientHelper.client
  //       .get(Uri.parse(ClientHelper.baseUrl + path), headers: {
  //     'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //   });
  //   //
  //   final dynamic responseData = json.decode(response.body);
  //   ModelKitap result = ModelKitap.fromJson(responseData);
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

  // ///Add Entity

  // Future<void> postEntity(String path, ModelKitap entity) async {
  //   await ClientHelper.client.post(
  //     Uri.parse(ClientHelper.baseUrl + path),
  //     headers: {
  //       'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode(entity),
  //   );
  // }
}
