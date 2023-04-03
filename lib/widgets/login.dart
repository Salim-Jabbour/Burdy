//done

import 'package:flutter/material.dart';
import 'package:zass/config/service-config.dart';
import 'package:zass/api/securestorage.dart';
import 'package:zass/config/user-information.dart';
import 'registerPage.dart';
import 'bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zass/provider/login_provider.dart';

//done
class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  initState() {
    test();
    super.initState();
  }

  late SecureStorage _check;

  test() async {
    _check = SecureStorage();
    await checkToken();
  }

  Future<void> checkToken() async {
    String? token = await _check.readToken('token');
    print('token 000-=' + token.toString());
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return BottomBar();
      }));
      
    }
  }

  //UserInformation userInformation = UserInformation();

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                child: Text('Welcome to the Burdy store',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.deepOrange, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    "assets/birdbag.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 2),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 8),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: loginprovider.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 2),
                child: Consumer<LoginProvider>(
                  builder: (context, loginprovider, child) => TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 8),
                          borderRadius: BorderRadius.circular(8)),
                      hintText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            loginprovider.changeVisibility();
                          },
                          icon: Icon(
                            loginprovider.changed
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.deepOrange,
                          )),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: loginprovider.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter password";
                      }
                      return null;
                    },
                    obscureText: loginprovider.changed,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 50, 50, 2),
                child: ElevatedButton(
                  child: const Text(
                    "Log In",
                    style: TextStyle(fontSize: 23),
                  ),
                  onPressed: () async {
                    await loginprovider.checkUser();
                    if (await loginprovider.checkUser()) {
                      Navigator.of(context).pushReplacementNamed('/bottombar');
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(52, 15, 52, 15),
                    ),
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.fromLTRB(30, 0, 30, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a Burdy account? "),
                    TextButton(
                      child: Text("Register",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 17.5)),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
