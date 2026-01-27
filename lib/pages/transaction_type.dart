import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/dashboard_controller.dart';
import '../global_controller/languages_controller.dart';
import '../global_controller/page_controller.dart';
import '../screens/commission_transfer_screen.dart';
import '../screens/hawala_currency_screen.dart';
import '../screens/hawala_list_screen.dart';
import '../screens/loan_screen.dart';
import '../screens/receipts_screen.dart';
import '../utils/colors.dart';
import '../widgets/bottomsheet.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer.dart';
import '../widgets/payment_button.dart';
import 'transactions.dart';

class TransactionsType extends StatefulWidget {
  TransactionsType({super.key});

  @override
  State<TransactionsType> createState() => _TransactionsTypeState();
}

class _TransactionsTypeState extends State<TransactionsType> {
  final box = GetStorage();

  final languagesController = Get.find<LanguagesController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final dashboardController = Get.find<DashboardController>();

  final Mypagecontroller mypagecontroller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return dashboardController.myerror.value != "Deactivated"
        ? Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
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
                              () => Text(
                                languagesController.tr("TRANSACTIONS_TYPE"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045,
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
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          PaymentButton(
                            buttonName: languagesController.tr(
                              "PAYMENT_RECEIPT_REQUEST",
                            ),
                            imagelink: "assets/icons/wallet.png",
                            mycolor: Color(0xff04B75D),
                            onpressed: () {
                              mypagecontroller.openSubPage(ReceiptsScreen());
                            },
                          ),
                          SizedBox(height: 10),
                          PaymentButton(
                            buttonName: languagesController.tr(
                              "REQUES_LOAN_BALANCE",
                            ),
                            imagelink: "assets/icons/transactionsicon.png",
                            mycolor: Color(0xff3498db),
                            onpressed: () {
                              mypagecontroller.openSubPage(RequestLoanScreen());
                            },
                          ),
                          SizedBox(height: 10),
                          PaymentButton(
                            buttonName: languagesController.tr("HAWALA"),
                            imagelink: "assets/icons/exchange.png",
                            mycolor: Color(0xffFE8F2D),
                            onpressed: () {
                              mypagecontroller.openSubPage(HawalaListScreen());
                            },
                          ),
                          SizedBox(height: 10),
                          PaymentButton(
                            buttonName: languagesController.tr("HAWALA_RATES"),
                            imagelink: "assets/icons/exchange-rate.png",
                            mycolor: Color(0xff4B7AFC),
                            onpressed: () {
                              mypagecontroller.openSubPage(
                                HawalaCurrencyScreen(),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          PaymentButton(
                            buttonName: languagesController.tr(
                              "BALANCE_TRANSACTIONS",
                            ),
                            imagelink: "assets/icons/transactionsicon.png",
                            mycolor: Color(0xffDE4B5E),
                            onpressed: () {
                              mypagecontroller.openSubPage(Transactions());
                            },
                          ),
                          SizedBox(height: 10),
                          PaymentButton(
                            buttonName: languagesController.tr(
                              "TRANSFER_COMISSION_TO_BALANCE",
                            ),
                            imagelink: "assets/icons/transactionsicon.png",
                            mycolor: Color(0xff9b59b6),
                            onpressed: () {
                              mypagecontroller.openSubPage(
                                CommissionTransferScreen(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dashboardController.myerror.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: GestureDetector(
                      onTap: () {
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
                      child: Container(
                        height: 45,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/whatsapp.png",
                              height: 30,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            KText(
                              text: languagesController.tr("CONTACTUS"),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: Text(
                          languagesController.tr("LOGOUT"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
