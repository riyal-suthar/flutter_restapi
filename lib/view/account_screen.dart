import 'package:flutter/material.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/routes/routes_name.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  LoginUser? user;
  @override
  void initState() {
    AppStore().getUserToken().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                user!.image!.isEmpty
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(user!.image.toString()),
                        radius: 60,
                      ),
                Text(
                  user!.username.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user!.email.toString(),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                    width: 130,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text("Edit Profile")))
              ],
            ),
            Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Cart"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    AppStore().removeToken();
                    setState(() {
                      Navigator.pushNamed(context, RouteName.logInScreen);
                    });
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Log out"),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("Version 1.0.0")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
