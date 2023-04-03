import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zass/api/securestorage.dart';
import 'package:zass/config/service-config.dart';

class   LoginProvider with ChangeNotifier {
  bool changed = false;

  void changeVisibility() {
    changed = !changed;
    notifyListeners();
  }

  TextEditingController name = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController email1 = new TextEditingController();

  TextEditingController password1 = new TextEditingController();

  TextEditingController number = new TextEditingController();

  TextEditingController address = new TextEditingController();

//توابع ومتحولات الربط
  var message, token;

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.signin);

  Future<bool> loginAuth() async {
    var response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        //'name':'${user.name}',  نفس يلي تحتا
        'email': email.text,
        'password': password.text,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      token = jsonResponse['token'];
      print(token);
      SecureStorage storage = SecureStorage();
      await storage.save(token);
      print('done');

      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else if (response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else {
      return false;
    }
  }

  Future<bool> checkUser() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await loginAuth()) {
      EasyLoading.showSuccess('your account logged in successfully',
          duration: Duration(milliseconds: 300));
      return true;
    } else {
      EasyLoading.showError(message); //put message
      return false;
    }
  }

  ///// done with logging in
  ///now register
  

  bool changed1 = false;

  void changeVisibility1() {
    changed1 = !changed1;
    notifyListeners();
  }

  var url1 = Uri.parse(ServerConfig.domainNameServer + ServerConfig.register);

  Future<bool> registerAuth() async {
    var response = await http.post(
      url1,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        //'name':'${user.name}',  نفس يلي تحتا
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'phone': number.text,
        'address': address.text,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      token = jsonResponse['token'];
      SecureStorage storage = SecureStorage();
      await storage.save(token);
      print('done');
      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      return false;
    } else {
      return false;
    }
  }

  Future<bool> addNewUserData() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await registerAuth()) {
      EasyLoading.showSuccess('your account registered successfully');
      return true;
    } else {
      EasyLoading.showError('error here');
      return false;
    }
  }
}
