// file: widgets/custom_full_screen_sheet.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jahandigital/controllers/drawer_controller.dart';
import 'package:jahandigital/global_controller/languages_controller.dart';
import 'package:jahandigital/global_controller/page_controller.dart';
import 'package:jahandigital/screens/helpscreen.dart';
import 'package:jahandigital/screens/termscondition.dart';
import 'package:jahandigital/utils/colors.dart';

import '../controllers/dashboard_controller.dart';
import '../controllers/sign_in_controller.dart';
import '../screens/change_password_screen.dart';
import '../screens/commission_group_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/selling_price_screen.dart';
import '../screens/sign_in_screen.dart';
import 'drawer.dart';

class CustomFullScreenSheet extends StatefulWidget {
  CustomFullScreenSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomFullScreenSheet(),
    );
  }

  @override
  State<CustomFullScreenSheet> createState() => _CustomFullScreenSheetState();
}

class _CustomFullScreenSheetState extends State<CustomFullScreenSheet> {
  final Mypagecontroller mypagecontroller = Get.find();

  final dashboardController = Get.find<DashboardController>();

  final languagesController = Get.find<LanguagesController>();

  MyDrawerController drawerController = Get.put(MyDrawerController());

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height - 80, // 100px gap from top
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 80,
              width: screenWidth,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 65,
                      width: 220,
                      child: Image.asset("assets/images/topimage.png"),
                    ),
                  ),
                  Center(
                    child: Icon(
                      FontAwesomeIcons.chevronDown,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                final profileImageUrl = dashboardController
                    .alldashboardData
                    .value
                    .data
                    ?.userInfo
                    ?.profileImageUrl;

                if (dashboardController.isLoading.value ||
                    profileImageUrl == null ||
                    profileImageUrl.isEmpty) {
                  return SizedBox();
                }

                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      profileImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.account_circle,
                          size: 50,
                          color: Colors.grey,
                        ); // fallback icon
                      },
                    ),
                  ),
                );
              }),
              SizedBox(width: 20),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Text(
                        dashboardController
                            .alldashboardData
                            .value
                            .data!
                            .userInfo!
                            .resellerName
                            .toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff8082ED),
                          fontFamily: languagesController.selectedlan == "Fa"
                              ? "Iranfont"
                              : "Roboto",
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 30),
          Obx(
            () => drawermenu(
              imagelink: "assets/icons/user.png",
              menuname: languagesController.tr("PROFILE"),
              onpressed: () {
                Navigator.pop(context);
                mypagecontroller.openSubPage(ProfileScreen());

                // drawerController.isOpen.value = false;
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Obx(
            () => drawermenu(
              imagelink: "assets/icons/set_sell_price.png",
              menuname: languagesController.tr("SET_SALE_PRICE"),
              onpressed: () {
                Navigator.pop(context);
                mypagecontroller.openSubPage(SellingPriceScreen());

                // drawerController.isOpen.value = false;
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Obx(
            () => drawermenu(
              imagelink: "assets/icons/set_vendor_sell_price.png",
              menuname: languagesController.tr("COMMISSION_GROUP"),
              onpressed: () {
                Navigator.pop(context);
                mypagecontroller.openSubPage(CommissionGroupScreen());

                // drawerController.isOpen.value = false;
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Obx(
            () => drawermenu(
              imagelink: "assets/icons/padlock.png",
              menuname: languagesController.tr("CHANGE_PASSWORD"),
              onpressed: () {
                Navigator.pop(context);
                mypagecontroller.openSubPage(ChangePasswordScreen());

                // drawerController.isOpen.value = false;
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          drawermenu(
            imagelink: "assets/icons/note-text.png",
            menuname: languagesController.tr("HELP"),
            onpressed: () {
              Navigator.pop(context);
              mypagecontroller.openSubPage(Helpscreen());
            },
          ),
          SizedBox(height: screenHeight * 0.015),
          drawermenu(
            imagelink: "assets/icons/whatsapp.png",
            menuname: languagesController.tr("CONTACTUS"),
            onpressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    contentPadding: EdgeInsets.all(0),
                    content: ContactDialogBox(),
                  );
                },
              );
            },
          ),
          SizedBox(height: screenHeight * 0.015),
          drawermenu(
            imagelink: "assets/icons/global.png",
            menuname: languagesController.tr("LANGUAGES"),
            onpressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(languagesController.tr("LANGUAGES")),
                    content: Container(
                      height: 350,
                      width: screenWidth,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: languagesController.alllanguagedata.length,
                        itemBuilder: (context, index) {
                          final data =
                              languagesController.alllanguagedata[index];
                          return GestureDetector(
                            onTap: () {
                              final languageName = data["name"].toString();

                              final matched = languagesController
                                  .alllanguagedata
                                  .firstWhere(
                                    (lang) => lang["name"] == languageName,
                                    orElse: () => {
                                      "isoCode": "en",
                                      "direction": "ltr",
                                    },
                                  );

                              final languageISO = matched["isoCode"]!;
                              final languageDirection = matched["direction"]!;

                              // Store selected language & direction
                              languagesController.changeLanguage(languageName);
                              box.write("language", languageName);
                              box.write("direction", languageDirection);

                              // Set locale based on ISO
                              Locale locale;
                              switch (languageISO) {
                                case "fa":
                                  locale = Locale("fa", "IR");
                                  break;
                                case "ar":
                                  locale = Locale("ar", "AE");
                                  break;
                                case "ps":
                                  locale = Locale("ps", "AF");
                                  break;
                                case "tr":
                                  locale = Locale("tr", "TR");
                                  break;
                                case "bn":
                                  locale = Locale("bn", "BD");
                                  break;
                                case "en":
                                default:
                                  locale = Locale("en", "US");
                              }

                              // Set app locale
                              setState(() {
                                EasyLocalization.of(context)!.setLocale(locale);
                              });

                              // Pop dialog
                              Navigator.pop(context);

                              print(
                                "🌐 Language changed to $languageName ($languageISO), Direction: $languageDirection",
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height: 45,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Row(
                                  children: [
                                    Center(
                                      child: Text(
                                        languagesController
                                            .alllanguagedata[index]["fullname"]
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: screenHeight * 0.015),
          drawermenu(
            imagelink: "assets/icons/logout.png",
            menuname: languagesController.tr("LOGOUT"),
            onpressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    content: LogoutDialogBox(),
                  );
                },
              );
            },
          ),
          Spacer(),
          Container(
            height: 150,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Color(0xffC8FACD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset("assets/images/whatsapp.png", height: 120),
                  SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(languagesController.tr("HELP_TITLE")),
                        GestureDetector(
                          onTap: () {
                            whatsapp();
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xff00AB55),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    languagesController.tr("CONTACTUS"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}

class LogoutDialogBox extends StatelessWidget {
  LogoutDialogBox({super.key});

  final signInController = Get.find<SignInController>();
  final Mypagecontroller mypagecontroller = Get.find();

  final box = GetStorage();

  final languagesController = Get.find<LanguagesController>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/rejected.png", height: 40),
              SizedBox(width: 15),
              Text(
                languagesController.tr("ARE_YOU_READY_TO_LOG_OUT"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              width: screenWidth,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        signInController.usernameController.clear();
                        signInController.passwordController.clear();

                        box.remove("userToken");

                        // mypagecontroller.changePage(
                        //   Homepages(),
                        //   isMainPage: false,
                        // );

                        Get.off(() => SignInScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            languagesController.tr("YES_IAMGOING_OUT"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            languagesController.tr("CANCEL"),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactDialogBox extends StatelessWidget {
  const ContactDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 300,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/icons/whatsapp2.png", height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "You will be redirected to the WhatsApp page to contact us. Continue?",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              width: screenWidth,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        whatsapp();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
