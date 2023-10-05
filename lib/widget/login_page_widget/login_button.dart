// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:case_study/service/login_register_services.dart';
import 'package:case_study/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            minimumSize: const Size(100, 60),
          ),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            bool? validate = widget.formKey.currentState?.validate();
            if (validate != null) {
              if (validate) {
                Response response = await LoginRegisterServices().register(widget.email.text, widget.password.text);
                if (response.statusCode == HttpStatus.ok) {
                  String token = jsonDecode(response.body)["token"];
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  StateProvider<String>((ref) => token);
                  await prefs.setString("token", token);
                  Get.offAll(() => const HomePage());
                } else {
                  showBottom(jsonDecode(response.body)["error"] ?? "Bilinmeyen hata");
                }
              }
            }

            setState(() {
              isLoading = false;
            });
          },
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Giriş Yap",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                )),
    );
  }

  void showBottom(String title) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builderContext) {
          return Container(
            alignment: Alignment.center,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        });
  }
}
