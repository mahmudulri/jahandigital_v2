import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jahandigital/controllers/create_transfer_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../global_controller/activation_controller.dart';
import '../models/dashboard_data_model.dart';
import '../utils/api_endpoints.dart';

final dashboardController = Get.find<DashboardController>();

class DashboardApi {
  final box = GetStorage();

  Future<DashboardDataModel> fetchDashboard() async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.dashboard,
    );

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    final decoded = json.decode(response.body);
    print("STATUS: ${response.statusCode}");

    if (response.statusCode == 403 && decoded['errors'] == 'Deactivated') {
      dashboardController.setDeactivated(decoded['errors'], decoded['message']);
      return DashboardDataModel();
    }

    if (response.statusCode == 200) {
      dashboardController.setDeactivated('', '');

      return DashboardDataModel.fromJson(decoded);
    }

    throw Exception('Failed to fetch dashboard');
  }
}
