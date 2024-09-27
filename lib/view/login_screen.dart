import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/viewModel/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 12,),
              TextFormField(
                controller: emailC,
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

                  logInProvider.useLogin(data, context);
                  // Navigator.pushReplacementNamed(context, RouteName.homeScreen);
                },
                child: logInProvider.isLoading
                    ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                    : const Text("Login"),
              ),
              const SizedBox(height: 21,),
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
