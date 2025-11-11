import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jahandigital/models/dashboard_data_model.dart';
import 'package:jahandigital/utils/api_endpoints.dart';

final box = GetStorage();

class DashboardController extends GetxController {
  RxString message = "".obs;
  RxString myerror = "".obs;
  var isLoading = false.obs;
  var alldashboardData = DashboardDataModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  /// Fetches dashboard data safely
  void fetchDashboardData() async {
    try {
      isLoading.value = true;
      final data = await fetchDashboard();
      if (data != null) {
        alldashboardData.value = data;
        myerror.value = "";
        message.value = "";
      }
    } catch (e) {
      print("Dashboard fetch error: $e");
      myerror.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Actual API call
  Future<DashboardDataModel?> fetchDashboard() async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.dashboard,
    );
    print("Dashboard API URL: $url");

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
      );

      print("Dashboard response status: ${response.statusCode}");
      final results = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // ✅ Success
        myerror.value = "";
        message.value = "";
        return DashboardDataModel.fromJson(results);
      } else if (response.statusCode == 403) {
        // ❌ Account Deactivated or Forbidden
        myerror.value = results["errors"] ?? "Deactivated";
        message.value = results["message"] ?? "Access forbidden";

        Fluttertoast.showToast(
          msg: message.value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // ⚠️ Instead of throwing, return null to avoid crash
        return null;
      } else {
        // ❌ Any other error
        message.value = "Failed to fetch dashboard. [${response.statusCode}]";
        Fluttertoast.showToast(
          msg: message.value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return null;
      }
    } catch (e) {
      print("Dashboard API exception: $e");
      message.value = "Something went wrong: $e";
      Fluttertoast.showToast(
        msg: "Network error! Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }
  }
}
