import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:jahandigital/controllers/bundle_controller.dart';
import 'package:jahandigital/controllers/confirm_pin_controller.dart';
import 'package:jahandigital/controllers/country_list_controller.dart';
import 'package:jahandigital/controllers/dashboard_controller.dart';
import 'package:jahandigital/controllers/drawer_controller.dart';
import 'package:jahandigital/global_controller/languages_controller.dart';
import 'package:jahandigital/helpers/capture_image_helper.dart';
import 'package:jahandigital/screens/credit_transfer.dart';
import 'package:jahandigital/screens/country_selection.dart';
import 'package:jahandigital/utils/colors.dart';
import 'package:jahandigital/widgets/bottomsheet.dart';
import 'package:jahandigital/widgets/button_one.dart';
import 'package:intl/intl.dart';
import 'package:jahandigital/widgets/drawer.dart';
import '../controllers/categories_controller.dart';
import '../controllers/company_controller.dart';
import '../controllers/slider_controller.dart';
import '../global_controller/page_controller.dart';
import '../screens/social_bundles.dart';

class Homepages extends StatefulWidget {
  Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  List serviceimages = [
    "assets/icons/service1.png",
    "assets/icons/service2.png",
    "assets/icons/service3.png",
    "assets/icons/service4.png",
  ];

  final dashboardController = Get.find<DashboardController>();

  final categorisListController = Get.find<CategorisListController>();

  int currentindex = 0;

  int currentSliderindex = 0;

  Timer? _timer;
  final box = GetStorage();

  int currentIndex = 0;
  final sliderController = Get.find<SliderController>();

  void _previousImage() {
    setState(() {
      currentIndex =
          (currentIndex -
              1 +
              sliderController
                  .allsliderlist
                  .value
                  .data!
                  .advertisements
                  .length) %
          sliderController.allsliderlist.value.data!.advertisements.length;
    });
  }

  void _nextImage() {
    setState(() {
      currentIndex =
          (currentIndex + 1) %
          sliderController.allsliderlist.value.data!.advertisements.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkforUpdate();
    companyController.fetchCompany();
    sliderController.fetchSliderData();
  }

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

  final confirmPinController = Get.find<ConfirmPinController>();

  final bundleController = Get.find<BundleController>();

  LanguagesController languagesController = Get.put(LanguagesController());
  MyDrawerController drawerController = Get.put(MyDrawerController());
  final companyController = Get.find<CompanyController>();

  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void onButtonTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CountryListController countrylistController = Get.put(
    CountryListController(),
  );

  @override
  Widget build(BuildContext context) {
    confirmPinController.numberController.clear();
    final Mypagecontroller mypagecontroller = Get.find();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF1F3FF),
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
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
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
                      Spacer(),
                      Obx(
                        () => dashboardController.isLoading.value == false
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      dashboardController.fetchDashboardData();
                                    },
                                    child: Text(
                                      dashboardController
                                          .alldashboardData
                                          .value
                                          .data!
                                          .userInfo!
                                          .resellerName
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                            0.022,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      languageController.tr("STATUS"),
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8082ED),
                        fontFamily: languagesController.selectedlan == "Fa"
                            ? "Iranfont"
                            : "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(height: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 140,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: PageView(
                          controller: _pageController,
                          physics:
                              NeverScrollableScrollPhysics(), // Disable swipe
                          children: [
                            BalanceWidget(),
                            SaleWidget(),
                            DebitWidget(),
                            ProfitWidget(),
                            CommissionWidget(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildButton(languageController.tr("BALANCE"), 0),
                              buildButton(languageController.tr("SALE"), 1),
                              buildButton(languageController.tr("DEBIT"), 2),
                              buildButton(languageController.tr("PROFIT"), 3),
                              buildButton(
                                languageController.tr("COMISSION"),
                                4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 130,
                width: screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        if (sliderController.isLoading.value) {
                          return SizedBox(); // লোডিং হলে কিছু দেখাবে না
                        }
                        if (sliderController.allsliderlist.value.data == null ||
                            sliderController
                                .allsliderlist
                                .value
                                .data!
                                .advertisements
                                .isEmpty) {
                          return Container(
                            color: Colors.transparent,
                          ); // যদি স্লাইডার না থাকে, তাহলে সাদা ব্যাকগ্রাউন্ড দেখাবে
                        }
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                sliderController
                                    .allsliderlist
                                    .value
                                    .data!
                                    .advertisements[currentIndex]
                                    .adSliderImageUrl
                                    .toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => CreditButton(
                  buttonName: languagesController.tr("CREDIT_TRANSFER"),
                  mycolor: Color(0xffFFFFFF),
                  onpressed: () {
                    mypagecontroller.changePage(
                      CreditTransfer(),
                      isMainPage: false,
                    );

                    print(box.read("afghanistan_id"));
                    print(box.read("afghanistan_flag"));
                  },
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Obx(
                    () => Text(
                      languageController.tr("SERVICES"),
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8082ED),
                        fontFamily: languagesController.selectedlan == "Fa"
                            ? "Iranfont"
                            : "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(height: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Obx(
                () => categorisListController.isLoading.value == false
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          crossAxisSpacing: 8.0, // Spacing between columns
                          mainAxisSpacing: 8.0, // Spacing between rows
                          childAspectRatio: 2.8,
                        ),
                        itemCount: categorisListController
                            .allcategorieslist
                            .value
                            .data!
                            .servicecategories!
                            .length,
                        itemBuilder: (context, index) {
                          final data = categorisListController
                              .allcategorieslist
                              .value
                              .data!
                              .servicecategories![index];

                          final imagePath =
                              serviceimages[index % serviceimages.length];
                          return GestureDetector(
                            onTap: () {
                              box.write(
                                "service_category_id",
                                categorisListController
                                    .allcategorieslist
                                    .value
                                    .data!
                                    .servicecategories![index]
                                    .id,
                              );

                              if (data.type.toString() == "nonsocial") {
                                mypagecontroller.changePage(
                                  InternetPack(),
                                  isMainPage: false,
                                );
                                countrylistController.fetchCountryData();
                              } else {
                                box.write("validity_type", "");

                                box.write("search_tag", "");
                                box.write(
                                  "service_category_id",
                                  categorisListController
                                      .allcategorieslist
                                      .value
                                      .data!
                                      .servicecategories![index]
                                      .id,
                                );

                                box.write("country_id", "");
                                box.write("company_id", "");
                                bundleController.finalList.clear();
                                bundleController.initialpage = 1;

                                mypagecontroller.changePage(
                                  SocialBundles(),
                                  isMainPage: false,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    imagePath,
                                    height: screenHeight * 0.045,
                                  ),
                                  Text(
                                    data.categoryName.toString(),
                                    style: TextStyle(
                                      color: Color(0xff454F5B),
                                      fontWeight: FontWeight.w800,
                                      fontSize: screenWidth * 0.030,
                                      fontFamily:
                                          languagesController.selectedlan ==
                                              "Fa"
                                          ? "Iranfont"
                                          : "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, int index) {
    bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => onButtonTap(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? AppColors.primaryColor : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  LanguagesController languagesController = Get.put(LanguagesController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Obx(
                () => Text(
                  languageController.tr("BALANCE"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: languagesController.selectedlan == "Fa"
                        ? "Iranfont"
                        : "Roboto",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 20,
                  child: Image.asset("assets/icons/line.png"),
                ),
              ),
              SizedBox(width: 20),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                              locale: 'en_US',
                              symbol: '',
                              decimalDigits: 2,
                            ).format(
                              double.parse(
                                dashboardController
                                    .alldashboardData
                                    .value
                                    .data!
                                    .balance
                                    .toString(),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily:
                                  languagesController.selectedlan == "Fa"
                                  ? "Iranfont"
                                  : "Roboto",
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            box.read("currency_code"),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaleWidget extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  LanguagesController languagesController = Get.put(LanguagesController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Obx(
                () => Text(
                  languageController.tr("SALE"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: languagesController.selectedlan == "Fa"
                        ? "Iranfont"
                        : "Roboto",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 20,
                  child: Image.asset("assets/icons/line.png"),
                ),
              ),
              SizedBox(width: 20),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  locale: 'en_US',
                                  symbol: '',
                                  decimalDigits: 2,
                                ).format(
                                  double.parse(
                                    dashboardController
                                        .alldashboardData
                                        .value
                                        .data!
                                        .totalSoldAmount
                                        .toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily:
                                      languagesController.selectedlan == "Fa"
                                      ? "Iranfont"
                                      : "Roboto",
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                box.read("currency_code"),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  locale: 'en_US',
                                  symbol: '',
                                  decimalDigits: 2,
                                ).format(
                                  double.parse(
                                    dashboardController
                                        .alldashboardData
                                        .value
                                        .data!
                                        .todaySale
                                        .toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily:
                                      languagesController.selectedlan == "Fa"
                                      ? "Iranfont"
                                      : "Roboto",
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                box.read("currency_code"),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DebitWidget extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  LanguagesController languagesController = Get.put(LanguagesController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Obx(
                () => Text(
                  languageController.tr("DEBIT"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: languagesController.selectedlan == "Fa"
                        ? "Iranfont"
                        : "Roboto",
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 20,
                  child: Image.asset("assets/icons/line.png"),
                ),
              ),
              SizedBox(width: 20),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                              locale: 'en_US',
                              symbol: '',
                              decimalDigits: 2,
                            ).format(
                              double.parse(
                                dashboardController
                                    .alldashboardData
                                    .value
                                    .data!
                                    .loanBalance
                                    .toString(),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily:
                                  languagesController.selectedlan == "Fa"
                                  ? "Iranfont"
                                  : "Roboto",
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            box.read("currency_code"),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfitWidget extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  LanguagesController languagesController = Get.put(LanguagesController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Obx(
                () => Text(
                  languageController.tr("PROFIT"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: languagesController.selectedlan == "Fa"
                        ? "Iranfont"
                        : "Roboto",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 20,
                  child: Image.asset("assets/icons/line.png"),
                ),
              ),
              SizedBox(width: 8),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  locale: 'en_US',
                                  symbol: '',
                                  decimalDigits: 2,
                                ).format(
                                  double.parse(
                                    dashboardController
                                        .alldashboardData
                                        .value
                                        .data!
                                        .totalRevenue
                                        .toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily:
                                      languagesController.selectedlan == "Fa"
                                      ? "Iranfont"
                                      : "Roboto",
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                box.read("currency_code"),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  locale: 'en_US',
                                  symbol: '',
                                  decimalDigits: 2,
                                ).format(
                                  double.parse(
                                    dashboardController
                                        .alldashboardData
                                        .value
                                        .data!
                                        .todayProfit
                                        .toString(),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily:
                                      languagesController.selectedlan == "Fa"
                                      ? "Iranfont"
                                      : "Roboto",
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                box.read("currency_code"),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommissionWidget extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  LanguagesController languagesController = Get.put(LanguagesController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Obx(
                () => Text(
                  languageController.tr("COMISSION"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: languagesController.selectedlan == "Fa"
                        ? "Iranfont"
                        : "Roboto",
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 20,
                  child: Image.asset("assets/icons/line.png"),
                ),
              ),
              SizedBox(width: 8),
              Obx(
                () => dashboardController.isLoading.value == false
                    ? Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                              locale: 'en_US',
                              symbol: '',
                              decimalDigits: 2,
                            ).format(
                              double.parse(
                                dashboardController
                                    .alldashboardData
                                    .value
                                    .data!
                                    .userInfo!
                                    .totalearning
                                    .toString(),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily:
                                  languagesController.selectedlan == "Fa"
                                  ? "Iranfont"
                                  : "Roboto",
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            box.read("currency_code"),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
