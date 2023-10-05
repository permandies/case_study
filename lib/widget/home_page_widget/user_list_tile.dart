import 'package:cached_network_image/cached_network_image.dart';
import 'package:case_study/model/user_model.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final User user;
  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {},
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(500)),
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              imageUrl: user.avatar!,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        title: Text("${user.firstName ?? ""} ${user.lastName ?? ""}"),
        subtitle: Text(user.email ?? ""),
      ),
    );
  }
}
