import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jahandigital/controllers/dashboard_controller.dart';
import 'package:jahandigital/controllers/order_list_controller.dart';
import 'package:jahandigital/controllers/sub_reseller_controller.dart';

import '../pages/homepages.dart';
import '../pages/network.dart';
import '../pages/orders.dart';
import '../pages/transaction_type.dart';

// class Mypagecontroller extends GetxController {
//   final selectedIndex = 0.obs;
//   final navigatorKey = GlobalKey<NavigatorState>();

//   /// lazy loaded tabs
//   final RxList<bool> _loadedTabs = <bool>[true, false, false, false].obs;

//   Widget _buildPage(int index) {
//     switch (index) {
//       case 0:
//         return Homepages();
//       case 1:
//         return TransactionsType();
//       case 2:
//         return Orders();
//       case 3:
//         return Network();
//       default:
//         return const SizedBox();
//     }
//   }

//   List<Widget> get pages => List.generate(
//     4,
//     (i) => _loadedTabs[i] ? _buildPage(i) : const SizedBox(),
//   );

//   /// Bottom tab click
//   void onTabSelected(int index) {
//     if (selectedIndex.value == index) return;
//     if (index == 2) {
//       // Orders tab
//       Get.find<OrderlistController>().onOrdersTabOpened();
//     }

//     _loadedTabs[index] = true;
//     selectedIndex.value = index;

//     // close sub pages on tab switch
//     navigatorKey.currentState?.popUntil((r) => r.isFirst);
//   }

//   /// Unified BACK handler
//   Future<void> handleBack({bool fromUI = false}) async {
//     final nav = navigatorKey.currentState;

//     // 1️⃣ sub page exists → pop
//     if (nav != null && nav.canPop()) {
//       nav.pop();
//       return;
//     }

//     // 2️⃣ UI back → do nothing on main page
//     if (fromUI) return;

//     // 3️⃣ hardware back on main page → exit popup
//     final result = await Get.dialog<bool>(
//       AlertDialog(
//         title: const Text("Exit App"),
//         content: const Text("Do you want to exit the app?"),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(result: false),
//             child: const Text("NO"),
//           ),
//           TextButton(onPressed: () => exit(0), child: const Text("YES")),
//         ],
//       ),
//     );
//   }

//   /// open inner page
//   void openSubPage(Widget page) {
//     navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
//   }
// }

//.........................................................................................

// class Mypagecontroller extends GetxController {

//   RxList<Widget> pageStack = <Widget>[Homepages()].obs;

//   int lastSelectedIndex = 0;

//   final List<Widget> mainPages = [
//     Homepages(),
//     TransactionsType(),
//     Orders(),
//     Network(),
//   ];

//   Function(int)? updateIndexCallback;

//   void setUpdateIndexCallback(Function(int) callback) {
//     updateIndexCallback = callback;
//   }

//   void changePage(Widget page, {bool isMainPage = true}) {
//     if (isMainPage) {
//       lastSelectedIndex = mainPages
//           .indexWhere((element) => element.runtimeType == page.runtimeType);
//       pageStack.value = [page]; // reset stack for main page change
//     } else {
//       pageStack.add(page);
//     }

//     if (updateIndexCallback != null) {
//       updateIndexCallback!(isMainPage ? lastSelectedIndex : -1);
//     }
//   }

//   bool goBack() {
//     if (pageStack.length > 1) {
//       pageStack.removeLast();
//       return false; // don't exit
//     } else {
//       return true; // allow exit
//     }
//   }

//   void goToMainPageByIndex(int index) {
//     lastSelectedIndex = index;
//     changePage(mainPages[index], isMainPage: true);
//   }
// }
//...........................................................................................//

class Mypagecontroller extends GetxController {
  final selectedIndex = 0.obs;

  final navigatorKey = GlobalKey<NavigatorState>();

  final List<Widget> mainPages = [
    Homepages(),
    TransactionsType(),
    Orders(),
    Network(),
  ];

  void onTabSelected(int index) {
    if (selectedIndex.value == index) return;

    if (index == 0) {
      Get.find<DashboardController>().onOrdersTabOpened();
    } else if (index == 1) {
      print(".............");
    } else if (index == 2) {
      Get.find<OrderlistController>().onOrdersTabOpened();
    } else if (index == 3) {
      Get.find<SubresellerController>().onOrdersTabOpened();
    } else {
      print("object");
    }
  }

  /// Bottom nav switch
  void goToMainPageByIndex(int index) {
    selectedIndex.value = index;

    // pop all sub pages when switching tab
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void openSubPage(Widget page) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  Future<bool> handleBack() async {
    final navigator = navigatorKey.currentState;

    if (navigator != null && navigator.canPop()) {
      navigator.pop();
      return false;
    }

    // if main page  → exit dialog
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(languagesController.tr("EXIT_APP")),
        content: Text(languagesController.tr("DO_YOU_WANT_TO_EXIT_APP")),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(languagesController.tr("NO")),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: Text(languagesController.tr("YES")),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}

//...................................................................................
