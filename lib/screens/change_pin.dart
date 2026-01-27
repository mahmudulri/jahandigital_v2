import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jahandigital/controllers/change_pin_controller.dart';
import 'package:jahandigital/global_controller/languages_controller.dart';
import 'package:jahandigital/global_controller/page_controller.dart';
import 'package:jahandigital/screens/profile_screen.dart';
import 'package:jahandigital/utils/colors.dart';
import 'package:jahandigital/widgets/bottomsheet.dart';
import 'package:jahandigital/widgets/button_one.dart';
import 'package:jahandigital/widgets/drawer.dart';

import 'change_balance.dart';

class ChangePinScreen extends StatelessWidget {
  ChangePinScreen({super.key});

  final ChangePinController changePinController = Get.put(
    ChangePinController(),
  );

  final languagesController = Get.find<LanguagesController>();
  final Mypagecontroller mypagecontroller = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Color(0xffF1F3FF)),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          mypagecontroller.handleBack();
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Icon(FontAwesomeIcons.chevronLeft),
                          ),
                        ),
                      ),
                      Spacer(),
                      Obx(
                        () => Text(
                          languagesController.tr("CHANGE_PIN"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.040,
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          CustomFullScreenSheet.show(context);
                        },
                        child: Image.asset(
                          "assets/icons/drawericon.png",
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xffF1F3FF)),
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              languagesController.tr("OLD_PIN"),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: screenHeight * 0.020,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => ChangePinBox(
                          hintText: languagesController.tr("ENTER_OLD_PIN"),
                          controller: changePinController.oldPinController,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              languagesController.tr("NEW_PIN"),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: screenHeight * 0.020,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => ChangePinBox(
                          hintText: languagesController.tr("ENTER_NEW_PIN"),
                          controller: changePinController.newPinController,
                        ),
                      ),
                      SizedBox(height: 25),
                      Obx(
                        () => DefaultButton(
                          buttonName:
                              changePinController.isLoading.value == false
                              ? languagesController.tr("CHANGE_NOW")
                              : languagesController.tr("PLEASE_WAIT"),
                          mycolor: AppColors.primaryColor,
                          onpressed: () {
                            if (changePinController
                                    .oldPinController
                                    .text
                                    .isEmpty ||
                                changePinController
                                    .newPinController
                                    .text
                                    .isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Fill the data",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              changePinController.change();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePinBox extends StatelessWidget {
  ChangePinBox({super.key, this.hintText, this.controller});

  String? hintText;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.070,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: Icon(Icons.visibility_off),
            ),
          ),
        ),
      ),
    );
  }
}
