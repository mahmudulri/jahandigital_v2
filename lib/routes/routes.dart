import 'package:get/get.dart';
import 'package:jahandigital/bindings/basebinding.dart';
import 'package:jahandigital/bindings/sign_in_binding.dart';
import 'package:jahandigital/bindings/splash_binding.dart';

import 'package:jahandigital/screens/base_screen.dart';
import 'package:jahandigital/screens/sign_in_screen.dart';
import 'package:jahandigital/splash_screen.dart';

const String splash = '/splash-screen';
const String signinscreen = '/sign-in-screen';
const String basescreen = '/base-screen';

List<GetPage> myroutes = [
  GetPage(name: splash, page: () => SplashScreen(), binding: SplashBinding()),
  GetPage(
    name: signinscreen,
    page: () => SignInScreen(),
    binding: SignInControllerBinding(),
  ),
  GetPage(
    name: basescreen,
    page: () => NewBaseScreen(),
    binding: Basebinding(),
  ),
];
