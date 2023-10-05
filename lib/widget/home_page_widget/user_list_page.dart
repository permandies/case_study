import 'package:case_study/model/user_response_model.dart';
import 'package:case_study/widget/home_page_widget/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserListPage extends StatefulWidget {
  final UsersResponse userReponse;
  final Function(int) pageChanged;
  const UserListPage({super.key, required this.userReponse, required this.pageChanged});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late int page0;
  late int page1;
  late int page2;
  @override
  void initState() {
    page0 = widget.userReponse.page! - 1;
    page1 = page0 + 1;
    page2 = page1 + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.userReponse.user!.length,
            itemBuilder: (context, index) {
              var currentUser = widget.userReponse.user![index];
              return UserListTile(
                user: currentUser,
              );
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  if (page0 != 0) {
                    page0--;
                    page1--;
                    page2--;
                    widget.pageChanged(page1);
                  }
                },
                icon: const Icon(
                  FontAwesomeIcons.angleLeft,
                  size: 30,
                )),
            Text(
              page0.toString(),
              style: TextStyle(fontSize: 18, color: page0 == 0 ? Colors.transparent : Colors.black54),
            ),
            const SizedBox(width: 6),
            Text(
              page1.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Text(
              page2.toString(),
              style: TextStyle(
                  fontSize: 18, color: page2 == widget.userReponse.totalPages! ? Colors.black54 : Colors.transparent),
            ),
            IconButton(
                onPressed: () {
                  if (page2 < widget.userReponse.totalPages! + 1) {
                    page0++;
                    page1++;
                    page2++;
                    widget.pageChanged(page1);
                  }
                },
                icon: const Icon(
                  FontAwesomeIcons.angleRight,
                  size: 30,
                )),
          ],
        ),
      ],
    );
  }
}
