import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/hawala_list_model.dart';
import '../utils/api_endpoints.dart';

class HawalalistApi {
  final box = GetStorage();
  Future<HawalaModel> fetchhawala(int pageNo) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.hawalalist}?page=$pageNo",
    );

    print("hawala $url");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
        'Content-Type': 'application/json',
      },
    );

    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return HawalaModel.fromJson(decodedBody);
    }

    // 🔴 Handle 403 – account deactivated
    if (response.statusCode == 403) {
      Fluttertoast.showToast(
        msg: decodedBody['message'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      throw Exception(decodedBody['message'] ?? 'Your account is deactivated');
    }

    // 🔴 Handle all other errors
    throw Exception(decodedBody['message'] ?? 'Failed to fetch hawala list');
  }
}
