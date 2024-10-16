import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/viewModel/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();
    final logInProvider = Provider.of<LogInProvider>(context);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImageAssets.instance.appLogin,
                height: 200,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: emailC,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                    hintText: 'Email or Username',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: passwordC,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87))),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Map data = {
                    "username": emailC.text.toString(),
                    "password": passwordC.text.toString(),
                  };

                  logInProvider.userLogin(data, context);
                  // Navigator.pushReplacementNamed(context, RouteName.homeScreen);
                },
                child: logInProvider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Login"),
              ),
              const SizedBox(
                height: 21,
              ),
              const Tooltip(
                message: "Username: emilys\nPassword: emilyspass",
                child: Icon(
                  CupertinoIcons.question_circle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
