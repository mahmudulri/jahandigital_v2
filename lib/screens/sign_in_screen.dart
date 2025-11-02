import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jahandigital/controllers/dashboard_controller.dart';
import 'package:jahandigital/controllers/sign_in_controller.dart';
import 'package:jahandigital/global_controller/page_controller.dart';
import 'package:jahandigital/global_controller/languages_controller.dart';
import 'package:jahandigital/routes/routes.dart';

import 'package:jahandigital/screens/sign_up_screen.dart';
import 'package:jahandigital/utils/colors.dart';
import 'package:jahandigital/widgets/authtextfield.dart';
import 'package:jahandigital/widgets/social_button.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/socialbuttonbox.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LanguagesController languagesController = Get.put(LanguagesController());
  // final Mypagecontroller mypagecontroller = Get.find();

  // final Mypagecontroller mypagecontroller = Get.find();

  final signInController = Get.find<SignInController>();

  final dashboardController = Get.find<DashboardController>();

  final String phoneNumber = "+93790781206";

  final box = GetStorage();

  Future<bool> _showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(languagesController.tr("EXIT_APP")),
            content: Text(languagesController.tr("DO_YOU_WANT_TO_EXIT_APP")),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(languagesController.tr("NO")),
              ),
              ElevatedButton(
                onPressed: () => exit(0),
                child: Text(languagesController.tr("YES")),
              ),
            ],
          ),
        ) ??
        false;
  }

  final Mypagecontroller mypagecontroller = Get.put(Mypagecontroller());
  Future<bool> _onWillPop() async {
    // আগে subpage থাকলে pop, না থাকলে exit dialog
    final allowExit = mypagecontroller.goBack();
    if (!allowExit) return false;
    return _showExitPopup();
  }

  @override
  Widget build(BuildContext context) {
    final Mypagecontroller mypagecontroller = Get.find();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xffF1F3FF)),
          height: screenHeight,
          width: screenWidth,
          child: ListView(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: 250,
                  // color: Colors.red,
                  child: Center(
                    child: Lottie.asset(
                      'assets/loties/signinlottie.json',
                      // width: 300,
                      // height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 0,
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        languagesController.tr("LANGUAGES"),
                                      ),
                                      content: Container(
                                        height: 350,
                                        width: screenWidth,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: languagesController
                                              .alllanguagedata
                                              .length,
                                          itemBuilder: (context, index) {
                                            final data = languagesController
                                                .alllanguagedata[index];
                                            return GestureDetector(
                                              onTap: () {
                                                final languageName =
                                                    data["name"].toString();

                                                final matched =
                                                    languagesController
                                                        .alllanguagedata
                                                        .firstWhere(
                                                          (lang) =>
                                                              lang["name"] ==
                                                              languageName,
                                                          orElse: () => {
                                                            "isoCode": "en",
                                                            "direction": "ltr",
                                                          },
                                                        );

                                                final languageISO =
                                                    matched["isoCode"]!;
                                                final languageDirection =
                                                    matched["direction"]!;

                                                // Store selected language & direction
                                                languagesController
                                                    .changeLanguage(
                                                      languageName,
                                                    );
                                                box.write(
                                                  "language",
                                                  languageName,
                                                );
                                                box.write(
                                                  "direction",
                                                  languageDirection,
                                                );

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
                                                  EasyLocalization.of(
                                                    context,
                                                  )!.setLocale(locale);
                                                });

                                                // Pop dialog
                                                Navigator.pop(context);

                                                print(
                                                  "🌐 Language changed to $languageName ($languageISO), Direction: $languageDirection",
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 5,
                                                ),
                                                height: 45,
                                                width: screenWidth,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
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
                              child: Text(
                                languagesController.tr("WELCOME_BACK"),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.025,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languagesController.tr("ENTER_YOUR_LOGIN_INFO"),
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: screenHeight * 0.020,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Authtextfield(
                      hinttext: languagesController.tr("USERNAME"),
                      controller: signInController.usernameController,
                    ),
                    SizedBox(height: 8),
                    Authtextfield(
                      hinttext: languagesController.tr("PASSWORD"),
                      controller: signInController.passwordController,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          languagesController.tr("FORGOT_YOUR_PASSWORD"),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: screenHeight * 0.016,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          languagesController.tr("PASSWORD_RECOVERY"),
                          style: TextStyle(
                            color: Color(0xff1890FF),
                            fontSize: screenHeight * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        if (signInController.usernameController.text.isEmpty ||
                            signInController.passwordController.text.isEmpty) {
                          Get.snackbar("Oops!", "Fill the text fields");
                        } else {
                          print("Attempting login...");
                          await signInController.signIn();

                          if (signInController.loginsuccess.value == false) {
                            dashboardController.fetchDashboardData();
                            // Navigating to the BottomNavigationbar page
                            // countryListController.fetchCountryData();
                            Get.toNamed(basescreen);

                            // if (box.read("direction") == "rtl") {
                            //   setState(() {
                            //     EasyLocalization.of(context)!
                            //         .setLocale(Locale('ar', 'AE'));
                            //   });
                            // } else {
                            //   setState(() {
                            //     EasyLocalization.of(context)!
                            //         .setLocale(Locale('en', 'US'));
                            //   });
                            // }
                          } else {
                            print("Navigation conditions not met.");
                          }
                        }
                      },
                      child: Container(
                        height: screenHeight * 0.060,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xff65AEE9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Obx(
                            () => Text(
                              signInController.isLoading.value == false
                                  ? languagesController.tr("LOGIN")
                                  : languagesController.tr("PLEASE_WAIT"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // SocialButton(),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          languagesController.tr("HAVE_NOT_REGISTERED_YET"),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: screenHeight * 0.018,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            // mypagecontroller.changePage(
                            //   SignUpScreen(),
                            //   isMainPage: false,
                            // );

                            Get.to(() => SignUpScreen());
                          },
                          child: Text(
                            languagesController.tr("REGISTER"),
                            style: TextStyle(
                              color: Color(0xff1890FF),
                              fontSize: screenHeight * 0.018,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              whatsapp();
                            },
                            child: Icon(FontAwesomeIcons.whatsapp, size: 40),
                          ),
                          SizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              showSocialPopup(context);
                            },
                            child: Image.asset(
                              "assets/icons/social-media.png",
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              _makePhoneCall(phoneNumber);
                            },
                            child: Icon(FontAwesomeIcons.phone, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }
}

class languageBox extends StatelessWidget {
  const languageBox({super.key, this.lanName, this.onpressed});
  final String? lanName;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: GestureDetector(
        onTap: onpressed,
        child: Container(
          margin: EdgeInsets.only(bottom: 6),
          height: 40,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              lanName.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String number) async {
  final Uri url = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

whatsapp() async {
  var contact = "+93790781206";
  var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
  var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    print("not found");
  }
}
