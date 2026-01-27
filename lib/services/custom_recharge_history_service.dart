import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jahandigital/models/custom_history_model.dart';

import '../controllers/order_list_controller.dart';

import '../models/sub_reseller_model.dart';
import '../utils/api_endpoints.dart';

class CustomRechargeHistoryApi {
  final box = GetStorage();
  Future<CustomHistoryModel> fetchcustomhistory(int pageNo) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl}orders?page=${pageNo}&order_type=custom_recharge",
    );
    print("order Url : " + url.toString());

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${box.read("userToken")}',
        'Content-Type': 'application/json',
      },
    );
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      // print(response.body.toString());
      final customhistorymodel = CustomHistoryModel.fromJson(
        json.decode(response.body),
      );

      return customhistorymodel;
    }
    if (response.statusCode == 403) {
      print(decodedBody.toString());
      Fluttertoast.showToast(
        msg: decodedBody['message'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      throw Exception(decodedBody['message'] ?? 'Your account is deactivated');
    }
    throw Exception(decodedBody['message'] ?? 'Failed to fetch data');
  }
}
