import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';
import '../global_controller/page_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<Mypagecontroller>(() => Mypagecontroller());
  }
}
