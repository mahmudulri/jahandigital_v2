import 'package:get/get.dart';
import 'package:jahandigital/controllers/company_controller.dart';
import 'package:jahandigital/models/dashboard_data_model.dart';

import '../services/dashboard_service.dart';

final companyController = Get.find<CompanyController>();

class DashboardController extends GetxController {
  void onOrdersTabOpened() {
    fetchDashboardData();
    companyController.fetchCompany();
  }

  final deactiveStatus = ''.obs;
  final deactivateMessage = ''.obs;
  var isLoading = false.obs;
  var alldashboardData = DashboardDataModel().obs;

  @override
  void onInit() {
    fetchDashboardData(); // ✅ এখানে call
    super.onInit();
  }

  void setDeactivated(String status, String message) {
    deactiveStatus.value = status;
    deactivateMessage.value = message;
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading(true);
      final value = await DashboardApi().fetchDashboard();
      alldashboardData.value = value;
    } catch (e) {
      print("Dashboard Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
