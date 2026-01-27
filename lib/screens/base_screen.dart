import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:jahandigital/utils/colors.dart';

import '../controllers/categories_controller.dart';
import '../controllers/company_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/recharge_config_controller.dart';
import '../global_controller/languages_controller.dart';
import '../global_controller/page_controller.dart';
import '../pages/transaction_type.dart';

class NewBaseScreen extends StatefulWidget {
  const NewBaseScreen({super.key});

  @override
  State<NewBaseScreen> createState() => _NewBaseScreenState();
}

class _NewBaseScreenState extends State<NewBaseScreen> {
  final dashboardController = Get.find<DashboardController>();
  final Mypagecontroller mypagecontroller = Get.put(Mypagecontroller());
  final languagesController = Get.find<LanguagesController>();
  final MyDrawerController drawerController = Get.put(MyDrawerController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final categorisListController = Get.find<CategorisListController>();
  final configController = Get.find<RechargeConfigController>();
  final companyController = Get.find<CompanyController>();

  Future<void> _checkforUpdate() async {
    print("checking");
    await InAppUpdate.checkForUpdate()
        .then((info) {
          setState(() {
            if (info.updateAvailability == UpdateAvailability.updateAvailable) {
              print("update available");
              _update();
            }
          });
        })
        .catchError((error) {
          print(error.toString());
        });
  }

  void _update() async {
    print("Updating");
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _checkforUpdate();
  }

  void _onTapNav(int index) {
    HapticFeedback.lightImpact();
    mypagecontroller.onTabSelected(index);
    print(index);

    if (mypagecontroller.selectedIndex.value == index) return;

    switch (index) {
      case 0: // HOME

        break;

      case 1: // TRANSACTIONS
        print("transactions.........");
        break;

      case 2: // ORDERS

        print("order.........");
        break;

      case 3: // NETWORK
        print("network.........");
        break;
    }

    mypagecontroller.goToMainPageByIndex(index);
  }

  String _labelFor(int index) {
    switch (index) {
      case 0:
        return languagesController.tr("HOME");
      case 1:
        return languagesController.tr("TRANSACTIONS");
      case 2:
        return languagesController.tr("ORDERS");
      case 3:
        return languagesController.tr("NETWORK");
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: mypagecontroller.handleBack,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xffF1F3FF),

        body: Navigator(
          key: mypagecontroller.navigatorKey,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => Obx(() {
                return IndexedStack(
                  index: mypagecontroller.selectedIndex.value,
                  children: mypagecontroller.mainPages,
                );
              }),
            );
          },
        ),

        bottomNavigationBar: Obx(() {
          if (drawerController.isOpen.value) return const SizedBox.shrink();

          return SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                left: displayWidth * .05,
                right: displayWidth * .05,
                bottom: 10,
              ),
              height: displayWidth * .155,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
                itemBuilder: (context, index) {
                  return Obx(() {
                    final bool isActive =
                        index == mypagecontroller.selectedIndex.value;

                    return InkWell(
                      onTap: () => _onTapNav(index),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: isActive
                                ? displayWidth * .32
                                : displayWidth * .18,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: isActive ? displayWidth * .12 : 0,
                              width: isActive ? displayWidth * .32 : 0,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),

                          // icons + labels (icon left, active label to the right)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: isActive
                                ? displayWidth * .31
                                : displayWidth * .18,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ICON always left
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      imagedata[index],
                                      height: 18,
                                      color: isActive
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                    ),
                                    // Non-active: label below icon
                                    if (!isActive) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        _labelFor(index),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),

                                // Active: label to the right inside bubble
                                if (isActive) ...[
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        _labelFor(index),
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: displayWidth * .03),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  final List<String> imagedata = const [
    "assets/icons/homeicon.png",
    "assets/icons/transactionsicon.png",
    "assets/icons/ordericon.png",
    "assets/icons/sub_reseller.png",
  ];
}
