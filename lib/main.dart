import 'package:case_study/controller/controller.dart';
import 'package:case_study/view/home_page/home_page.dart';
import 'package:case_study/view/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isloggedIn = await setup();
  Get.put(Controller());

  runApp(ProviderScope(child: MyApp(isloggedIn)));
}

class MyApp extends ConsumerWidget {
  final bool isLoggedIn;
  const MyApp(this.isLoggedIn, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GetMaterialApp(
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}

Future<bool> setup() async {
  final getIt = GetIt.instance;
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
  String? token = getIt<SharedPreferences>().getString("token");

  if (token != null) {
    return true;
  } else {
    return false;
  }
}
