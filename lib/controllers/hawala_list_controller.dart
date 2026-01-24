import 'package:get/get.dart';

import '../models/hawala_list_model.dart';
import '../services/hawala_list_service.dart';

class HawalaListController extends GetxController {
  // @override
  // void onInit() {
  //   fetchhawala();
  //   super.onInit();
  // }
  int initialpage = 1;
  var isLoading = false.obs;

  var allhawalalist = HawalaModel().obs;

  void fetchhawala() async {
    try {
      isLoading(true);
      await HawalalistApi().fetchhawala(initialpage).then((value) {
        allhawalalist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
