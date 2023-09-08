import 'dart:convert';

import 'package:kutuphane_mobil/Models/token_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ClientHelper extends GetxController {
  static const String baseUrl = "http://192.168.1.177/api/";
  static http.Client client = http.Client();
  static TokenModel tokenn = TokenModel();

  static setToken(TokenModel token) {
    tokenn = token;

    client = http.Client();

    client.head(Uri.parse(baseUrl), headers: {
      'Authorization': 'Bearer ${token.accessToken}',
    });
  }

  static Future<TokenModel> getToken(String userName, String password) async {
    const serviceUrl = "http://192.168.1.177/token";
    final data = {
      'grant_type': 'password',
      'username': userName,
      'password': password,
    };

    final response = await client.post(Uri.parse(serviceUrl), body: data);
    //print(response.body);
    var token = tokenModelFromJson(response.body);

    return token;
  }
}

mixin EntityMixin<T> {
  Future<List<T>> getAllEntity(String path,
      {Function(int sayfaSayisi)? sayi}) async {
    final response = await http.get(
      Uri.parse(ClientHelper.baseUrl + path),
      headers: {
        'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
      },
    );

    final List<dynamic> responseData = json.decode(
        response.body); //dart dilinde kullanılan bir nesneye dönüştürüyor.

    List<T> resultList = responseData.map((item) => fromJson(item)).toList();
    return resultList;
  }

  Future<List<T>> getAllEntitySearch(String path,
      {Function(int sayfaSayisi)? sayi}) async {
    final response = await http.post(
      Uri.parse(ClientHelper.baseUrl + path),
      headers: {
        'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
      },
    );

    final List<dynamic> responseData = json.decode(response.body);

    List<T> resultList = responseData.map((item) => fromJson(item)).toList();
    return resultList;
  }

  Future<List<T>> getAllEntityS(String path,
      {required Function(int? sayfaSayisi) func}) async {
    final response = await http.get(
      Uri.parse(ClientHelper.baseUrl + path),
      headers: {
        'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
      },
    );
    var data = jsonDecode(response.body);
    func(data["PageCount"]);
    final List<dynamic> responseData = json.decode(jsonEncode(data["Data"]));

    List<T> resultList = responseData.map((item) => fromJson(item)).toList();
    return resultList;
  }

  Future<T> getEntity(String path) async {
    final response = await http.get(
      Uri.parse(ClientHelper.baseUrl + path),
      headers: {'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'},
    );
    final dynamic responseData = json.decode(response.body);

    T result = fromJson(responseData);
    return result;
  }

  Future<void> entityDelete(String path, String id) async {
    await http.delete(
      Uri.parse("${ClientHelper.baseUrl}$path/$id"),
      headers: {'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}'},
    );
  }

  Future<void> postEntity(String path, T entity) async {
    await http.post(
      Uri.parse(ClientHelper.baseUrl + path),
      headers: {
        'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
        "Content-Type": "application/json",
      },
      body: jsonEncode(toJson(entity)),
    );
  }

  Future<void> entityUpdate(String path, String id, T updatedEntity) async {
    await http.put(
      Uri.parse("${ClientHelper.baseUrl}$path/$id"),
      headers: {
        'Authorization': 'Bearer ${ClientHelper.tokenn.accessToken}',
        "Content-Type": "application/json",
      },
      body: jsonEncode(toJson(updatedEntity)),
    );
  }

  T fromJson(
      dynamic
          json); // Abstract method to parse JSON// gelen veriyi t modeline çeviriyo
  dynamic toJson(
      T entity); // Abstract method to convert to JSON //Jsona çeviriyo
}

//   // static Future<List<BaseEntity>> getAllEntity(String path) async {
//   //   final response = await client.get(
//   //     Uri.parse(baseUrl + path),
//   //     headers: {'Authorization': 'Bearer ${tokenn.accessToken}'},
//   //   );
//   //   final List<dynamic> responseData = json.decode(response.body);
//   //   List<ModelYayinEvi> resultList =
//   //       responseData.map((item) => ModelYayinEvi.fromJson(item)).toList();

//   //   print(resultList);
//   //   return resultList;
//   // }
// ///////////////////

// /////
//   static Future<T> getEntity<T>(String path) async {
//     final response = await client.get(Uri.parse(baseUrl + path));
//     return json.decode(response.body) as T;
//   }

//   static Future<void> postEntity<T>(String path, T entity) async {
//     await client.post(
//       Uri.parse(baseUrl + path),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(entity),
//     );
//   }

//   static Future<void> entityDelete(String path, String id) async {
//     await client.delete(Uri.parse('$baseUrl$path/$id'));
//   }

//   static Future<void> entityUpdate<T>(String path, String id, T entity) async {
//     await client.put(
//       Uri.parse('$baseUrl$path/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(entity),
//     );
//   }

