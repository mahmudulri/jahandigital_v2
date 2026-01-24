import 'package:get/get.dart';

import '../models/dashboard_data_model.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionController extends GetxController {
  int initialpage = 1;

  RxList<ResellerBalanceTransaction> finalList =
      <ResellerBalanceTransaction>[].obs;

  var isLoading = false.obs;

  var alltransactionlist = TransactionModel().obs;

  void fetchTransactionData() async {
    try {
      isLoading(true);
      await TransactionApi().fetchTransaction(initialpage).then((value) {
        alltransactionlist.value = value;

        if (alltransactionlist.value.data != null) {
          finalList.addAll(
            alltransactionlist.value.data!.resellerBalanceTransactions,
          );
        }

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
