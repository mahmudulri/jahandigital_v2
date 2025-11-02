import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controller/languages_controller.dart';

class Authtextfield extends StatefulWidget {
  final String hinttext;
  final TextEditingController? controller;

  const Authtextfield({
    super.key,
    required this.hinttext,
    this.controller,
  });

  @override
  State<Authtextfield> createState() => _AuthtextfieldState();
}

class _AuthtextfieldState extends State<Authtextfield> {
  LanguagesController languagesController = Get.put(LanguagesController());
  bool _obscureText = true; // password hide/show flag

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
        ),
        color: const Color(0xffF9FAFB),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: widget.controller,
                obscureText:
                    widget.hinttext == languagesController.tr("PASSWORD")
                        ? _obscureText
                        : false,
                keyboardType: widget.hinttext == "Enter amount"
                    ? TextInputType.phone
                    : TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hinttext,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            if (widget.hinttext == languagesController.tr("PASSWORD")) ...[
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
