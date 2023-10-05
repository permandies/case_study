import 'package:case_study/widget/login_page_widget/login_button.dart';
import 'package:case_study/widget/login_page_widget/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailTextController.text = "eve.holt@reqres.in";
    passwordTextController.text = "cityslicka";
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: MyTextField(
                  validator: (v) {
                    if (v == null) {
                      return "Lütfen bir e-posta adresi girin";
                    } else if (!GetUtils.isEmail(v.trim())) {
                      return "Lütfen geçerli bir e-posta adresi girin";
                    } else {}
                    return null;
                  },
                  title: "E-posta",
                  label: "example@gmail.com",
                  textEditingController: emailTextController,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: MyTextField(
                  validator: (v) {
                    if (v == null) {
                      return "Lütfen bir şifte girin";
                    } else if (v.split("").length < 6) {
                      return "Şifreniz en az 6 haneli olmalı";
                    }
                    return null;
                  },
                  title: "Şifre",
                  label: "En az 6 haneli",
                  textEditingController: passwordTextController,
                  isThisPasswordField: true,
                  textInputType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 30),
              LoginButton(formKey: key, email: emailTextController, password: passwordTextController),
            ],
          ),
        ),
      ),
    );
  }
}
