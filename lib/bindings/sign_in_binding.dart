import 'package:get/get.dart';
import 'package:jahandigital/controllers/sign_in_controller.dart';

import '../global_controller/page_controller.dart';

class SignInControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<Mypagecontroller>(() => Mypagecontroller());
  }
}
