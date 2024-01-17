import 'package:flutter/cupertino.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/repository/repository.dart';
import 'package:flutter_restapi/data/services/api_response.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/utils/toastMessage.dart';

class LogInProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> useLogin(dynamic data, BuildContext context) async {
    setLoading(true);
    _appRepository.userLogIn(data).then((value) {
      if (value!.token == '' || value.token == null) {
        toastMessage("Something went wrong");
      } else {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      }

      AppStore().setUserToken(value);
      print("value of token : ${value.token}");

      setLoading(false);
    }).onError((error, stackTrace) {
      print(error.toString());
      toastMessage("Something went wrong...!");
      setLoading(false);
    });
  }

  Future<void> registerUser(context, dynamic data) async {
    setLoading(true);
    _appRepository.newUser(data).then((value) {
      toastMessage("Registered Successfully..");
      Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      AppStore().setUserToken(value);

      setLoading(false);
    }).onError((error, stackTrace) {
      toastMessage("Something went wrong...!");
      ApiResponse.error(error.toString());
      setLoading(false);
    });
  }

  Future<void> updateUser(context, dynamic data) async {
    setLoading(true);
    _appRepository.updateUser(data).then((value) {
      toastMessage("Profile Updated Successfully..");
      AppStore().setUserToken(value);

      setLoading(false);
    }).onError((error, stackTrace) {
      toastMessage("Something went wrong...!");
      ApiResponse.error(error.toString());
      setLoading(false);
    });
  }

  //---- for admin use
  Future<void> deleteUser() async {
    setLoading(true);
    _appRepository.deleteUser().then((value) {
      toastMessage("User deleted successfully..");
      AppStore().setUserToken(value);

      setLoading(false);
    }).onError((error, stackTrace) {
      toastMessage("Something went wrong...!");
      ApiResponse.error(error.toString());
      setLoading(false);
    });
  }
}
