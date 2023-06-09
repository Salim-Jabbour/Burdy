//done

import 'package:flutter/material.dart';
import 'package:zass/api/securestorage.dart';
import 'package:zass/config/service-config.dart';
import 'login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zass/widgets/bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zass/provider/login_provider.dart';

//done
class MyRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerprovider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // color: Color.fromARGB(40, 250, 100, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 29,
                ),

                Image.asset(
                  "assets/freebirds_full.jpg",
                  fit: BoxFit.fill,
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  'Hurry up and GO make a Burdy account!',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),

                SizedBox(
                  height: 40,
                ),

                //the enter name field
                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Name ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: registerprovider.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter name";
                      }
                      return null;
                    },
                  ),
                ),

                //the enter email field

                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Email ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: registerprovider.email1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter email";
                      }
                      return null;
                    },
                  ),
                ),

                //the enter password field

                Container(
                  padding: EdgeInsets.all(4),
                  child: Consumer<LoginProvider>(
                    builder: (context, clp, child) => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                          hintText: 'Password ',
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.deepOrange,
                          ),
                          suffixIcon: IconButton(
                            color: Colors.deepOrange,
                            icon: Icon(
                              clp.changed1
                                  ? Icons.visibility_off
                                  : Icons.visibility_rounded,
                            ),
                            onPressed: () {
                              clp.changeVisibility1();
                            },
                          )),
                      controller: registerprovider.password1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter password";
                        }
                        return null;
                      },
                      obscureText: registerprovider.changed1,
                    ),
                  ),
                ),

                //the enter number field

                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Number ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_android,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: registerprovider.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter number";
                      }
                      return null;
                    },
                  ),
                ),

                // the enter adress field
                Container(
                  padding: EdgeInsets.all(4),
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Address ',
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: registerprovider.address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter address";
                      }
                      return null;
                    },
                  ),
                ),

                ///the button

                ElevatedButton(
                  onPressed: () async {
                    bool c = await registerprovider.addNewUserData();
                    if (c) {
                      Navigator.of(context).pushReplacementNamed('/bottombar');
                    }
                  },
                  child: Icon(
                    Icons.add,
                  ),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepOrange),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/login');
                  },
                  child: Text(
                    'Already have an account !',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 17.5),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ].toList(),
            ),
          ),
        ),
      ),
    );
  }
}
