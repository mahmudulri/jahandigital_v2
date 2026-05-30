import 'package:get/get.dart';

import '../models/sub_reseller_model.dart';
import '../services/sub_reseller_service.dart';

class SubresellerController extends GetxController {
  void onOrdersTabOpened() {
    print("networkcalled..............");

    fetchSubReseller();
  }

  var isLoading = false.obs;

  var allsubresellerData = SubResellerModel().obs;

  Future<void> fetchSubReseller() async {
    print("fetchSubReseller called");

    try {
      isLoading.value = true;

      final value = await SubResellerApi().fetchSubReseller();
      allsubresellerData.value = value;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false; // ✅ এক জায়গায়
    }
  }
}
