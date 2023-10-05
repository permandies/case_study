import 'dart:convert';
import 'package:case_study/controller/controller.dart';
import 'package:case_study/controller/globals.dart';
import 'package:case_study/model/user_response_model.dart';
import 'package:case_study/service/user_services.dart';
import 'package:case_study/widget/home_page_widget/eror_page.dart';
import 'package:case_study/widget/home_page_widget/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  Controller controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TokenWidget(),
      ),
      body: FutureBuilder(
          future: getUsers(currentPage),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErorPage();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return UserListPage(
                  pageChanged: (page) {
                    currentPage = page;
                    setState(() {});
                  },
                  userReponse: snapshot.data!,
                );
              }
              return const Text("Kullanıcı bulunamadı");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<UsersResponse?> getUsers(int page) async {
    if (controller.userResponses[page] == null) {
      Response response = await GetIt.I<UserServices>().getUsers(currentPage);
      UsersResponse userReponse = UsersResponse.fromJson(jsonDecode(response.body));
      controller.userResponses[page] = userReponse;
    }

    return controller.userResponses[page];
  }
}

class TokenWidget extends ConsumerWidget {
  const TokenWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var token = ref.watch(tokenProvider);
    return Text(
      "Kullanıcı token: ${token ?? ""}",
      style: const TextStyle(color: Colors.white),
    );
  }
}
