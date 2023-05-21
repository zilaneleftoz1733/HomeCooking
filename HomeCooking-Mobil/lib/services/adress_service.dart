import 'package:shared_preferences/shared_preferences.dart';

String userAdress = '';

class AdressService {
  Future<String?> getUserAdress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userAdress = prefs.getString('currentUserID') ?? '';

    return userAdress;
  }

  void saveUserAdress(String newAdress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUserID', newAdress);
    userAdress = newAdress;
  }
}
