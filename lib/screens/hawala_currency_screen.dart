import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jahandigital/helpers/capture_image_helper.dart';
import 'package:jahandigital/utils/colors.dart';

import '../controllers/hawala_currency_controller.dart';
import '../global_controller/languages_controller.dart';
import '../global_controller/page_controller.dart';
import '../pages/transaction_type.dart';
import '../widgets/bottomsheet.dart';

class HawalaCurrencyScreen extends StatefulWidget {
  HawalaCurrencyScreen({super.key});

  @override
  State<HawalaCurrencyScreen> createState() => _HawalaCurrencyScreenState();
}

class _HawalaCurrencyScreenState extends State<HawalaCurrencyScreen> {
  final box = GetStorage();

  final hawalacurrencycontroller = Get.find<HawalaCurrencyController>();
  final languagesController = Get.find<LanguagesController>();

  final Mypagecontroller mypagecontroller = Get.find();
  @override
  void initState() {
    super.initState();
    hawalacurrencycontroller.fetchcurrency();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          languagesController.tr("HAWALA_RATES"),
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
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Container(
            //   height: 250,
            //   width: screenWidth,
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 35,
            //         width: screenWidth,
            //         decoration: BoxDecoration(
            //           color: AppColors.primaryColor,
            //         ),
            //         child: Row(
            //           children: [
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: AppColors.primaryColor,
            //                   border: Border(
            //                     left: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   languagesController.tr("AMOUNT"),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: AppColors.primaryColor,
            //                   border: Border(
            //                     left: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   languagesController.tr("FROM"),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: AppColors.primaryColor,
            //                   border: Border(
            //                     left: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   languagesController.tr("TO"),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: AppColors.primaryColor,
            //                   border: Border(
            //                     left: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   languagesController.tr("BUY"),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: AppColors.primaryColor,
            //                   border: Border(
            //                     left: BorderSide(
            //                       width: 1,
            //                       color: Colors.grey,
            //                     ),
            //                   ),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   languagesController.tr("SELL"),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         child: Expanded(
            //             child: Obx(() => hawalacurrencycontroller
            //                         .isLoading.value ==
            //                     false
            //                 ? ListView.builder(
            //                     itemCount: hawalacurrencycontroller
            //                         .allcurrencylist.value.data!.rates!.length,
            //                     itemBuilder: (context, index) {
            //                       final data = hawalacurrencycontroller
            //                           .allcurrencylist
            //                           .value
            //                           .data!
            //                           .rates![index];
            //                       return Container(
            //                         height: 50,
            //                         width: screenWidth,
            //                         decoration: BoxDecoration(),
            //                         child: Row(
            //                           children: [
            //                             Expanded(
            //                               flex: 1,
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                   border: Border(
            //                                     bottom: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     left: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     data.amount.toString(),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Expanded(
            //                               flex: 1,
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                   // border: Border.all(
            //                                   //   width: 1,
            //                                   //   color: Colors.grey,
            //                                   // ),
            //                                   border: Border(
            //                                     bottom: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     left: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     textAlign: TextAlign.center,
            //                                     data.fromCurrency?.name ?? "-",
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Expanded(
            //                               flex: 1,
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                   border: Border(
            //                                     bottom: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     left: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     textAlign: TextAlign.center,
            //                                     data.toCurrency?.name ?? "-",
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Expanded(
            //                               flex: 1,
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                   border: Border(
            //                                     bottom: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     left: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     textAlign: TextAlign.center,
            //                                     "${data.buyRate ?? '-'} ${data.toCurrency?.symbol ?? ''}",
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Expanded(
            //                               flex: 1,
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                   border: Border(
            //                                     bottom: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     right: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                     left: BorderSide(
            //                                       width: 1,
            //                                       color: Colors.grey,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     textAlign: TextAlign.center,
            //                                     "${data.sellRate ?? '-'} ${data.toCurrency?.symbol ?? ''}",
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     },
            //                   )
            //                 : Center(
            //                     child: CircularProgressIndicator(),
            //                   ))),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10),
            Expanded(
              child: Obx(
                () => hawalacurrencycontroller.isLoading.value == false
                    ? SingleChildScrollView(
                        // vertical scroll only
                        child: DataTable(
                          columnSpacing: 10,
                          headingRowHeight: 36,
                          dataRowMinHeight: 34,
                          dataRowMaxHeight: 40,
                          headingRowColor: WidgetStateProperty.all(
                            Colors.white,
                          ),
                          border: TableBorder.all(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),

                          // 👇 This aligns text vertically in the middle
                          headingTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),

                          // 👇 Forces centered header text alignment
                          columns: [
                            DataColumn(
                              label: Text(
                                languagesController.tr("AMOUNT"),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    languagesController.tr("FROM"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    languagesController.tr("TO"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    languagesController.tr("BUY"),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    languagesController.tr("SELL"),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],

                          rows: hawalacurrencycontroller
                              .allcurrencylist
                              .value
                              .data!
                              .rates!
                              .map(
                                (data) => DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data.amount.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data.fromCurrency?.name ?? "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data.toCurrency?.name ?? "-",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          "${data.buyRate ?? '-'} ${data.toCurrency?.symbol ?? ''}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          "${data.sellRate ?? '-'} ${data.toCurrency?.symbol ?? ''}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
