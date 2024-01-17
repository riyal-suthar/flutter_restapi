import 'package:flutter/material.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
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
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                    hintText: 'Enter email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87))),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: passwordC,
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87))),
              ),
              SizedBox(
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
                    ? CircularProgressIndicator()
                    : Text("Login"),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
