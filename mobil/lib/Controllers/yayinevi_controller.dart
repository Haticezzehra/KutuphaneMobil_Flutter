import 'package:get/get.dart';
import 'package:kutuphane_mobil/Controllers/get_token_controller.dart';
import 'package:kutuphane_mobil/Models/model_yayin_evi.dart';

class YayinEviController extends GetxController
    with EntityMixin<ModelYayinEvi> {
  @override
  toJson(ModelYayinEvi entity) {
    return entity.toJson();
  }

  @override
  ModelYayinEvi fromJson(json) {
    return ModelYayinEvi.fromJson(json);
  }

  // Future<List<ModelYayinEvi>> getAllEntity(String path) async {
  //   final response = await ClientHelper.client.get(
  //     Uri.parse(ClientHelper.baseUrl + path),
  //     headers: {'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'},

  //   );
  //   final List<dynamic> responseData = json.decode(response.body);
  //   List<ModelYayinEvi> resultList =
  //       responseData.map((item) => ModelYayinEvi.fromJson(item)).toList();
  //   //print(resultList);
  //   return resultList;
  // }

  // ////getEntity
  // Future<ModelYayinEvi> getEntity(String path) async {
  //   final response = await ClientHelper.client
  //       .get(Uri.parse(ClientHelper.baseUrl + path), headers: {
  //     'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //   });
  //   //
  //   final dynamic responseData = json.decode(response.body);
  //   ModelYayinEvi result = ModelYayinEvi.fromJson(responseData);
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

  // Future<void> postEntity(String path, ModelYayinEvi entity) async {
  //   await ClientHelper.client.post(
  //     Uri.parse(ClientHelper.baseUrl + path),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //     },
  //     body: json.encode(entity),
  //   );
  //   //print(json.encode(entity));
  // }

  // ///
  // Future<void> entityUpdate(
  //     String path, String id, ModelYayinEvi entity) async {
  //   await ClientHelper.client.put(
  //     Uri.parse('$ClientHelper.baseUrl$path/$id'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'
  //     },
  //     body: json.encode(entity),
  //   );
  // }
}
////
 