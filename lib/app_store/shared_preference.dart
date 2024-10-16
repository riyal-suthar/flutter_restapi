import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStore {
  setUserToken(UserM user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('user_id', user.id!);
    sp.setString('user_token', user.accessToken.toString());
    sp.setString('user_name', user.username.toString());
    sp.setString('user_image', user.image.toString());
    sp.setString('user_email', user.email.toString());
  }

  Future<UserM> getUserToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    int? userId = sp.getInt('user_id');
    String? userToken = sp.getString('user_token');
    String? userName = sp.getString('user_name');
    String? userImage = sp.getString('user_image');
    String? userEmail = sp.getString('user_email');

    return UserM(
      id: userId,
      accessToken: userToken,
      username: userName,
      email: userEmail,
      image: userImage,
    );
  }

  Future<dynamic> getMyId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    int? userId = sp.getInt('user_id');
    return userId;
  }

  removeToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('user_id');
    sp.remove('user_token');
    sp.remove('user_name');
    sp.remove('user_email');
    sp.remove('user_image');
  }
}
