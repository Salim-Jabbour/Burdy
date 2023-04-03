import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zass/api/securestorage.dart';
import 'package:zass/config/service-config.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as used;

import 'package:zass/models/addproductclass.dart';

class AddProductProvider with ChangeNotifier {
  TextEditingController name = new TextEditingController();

  TextEditingController category = new TextEditingController();

  TextEditingController availableAmount = new TextEditingController();

  TextEditingController price = new TextEditingController();

  late AddProduct prod;
  String id = '4';

  DateTime? expirationDate, expirationDate1, expirationDate2, expirationDate3;

  String time = "?", time1 = "?", time2 = "?", time3 = "?";

  double sale1 = 0, sale2 = 0, sale3 = 0;

  late String periodsString;

  used.File? imageController;

  final picker = ImagePicker();

  Future takePhotoFromGallery() async {
    final selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (selectedImage != null) {
      imageController = used.File(selectedImage.path);
    }
    notifyListeners();
  }

  Future takePhotoFromCamera() async {
    final selectedImage = await picker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      imageController = used.File(selectedImage.path);
    }
    notifyListeners();
  }

  String? valueChoosen;
  var id1;
  List listItem = ["Sports", "Technology", "Food", "Others"];

  void editCategory() {
    if (valueChoosen == "Sports") {
      id1 = '1';
    } else if (valueChoosen == "Technology") {
      id1 = '2';
    } else if (valueChoosen == "Food") {
      id1 = '3';
    } else {
      id1 = '4';
    }
    notifyListeners();
  }

  void changeCategory(Object? n) {
    valueChoosen = n as String?;
    notifyListeners();
  }

  void changeDate() {
    time = DateFormat('yyyy-MM-dd').format(expirationDate!);
    notifyListeners();
  }

  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.newproduct);

  //sending to back
  SecureStorage storage = SecureStorage();

  Future<bool> newProductCheck() async {
    var token = await storage.read();
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageController!.path,
      ),
    );
    request.headers.addAll(
        {'Accept': 'Application/json', 'Authorization': 'Bearer $token'});
    request.fields['name'] = name.text;
    request.fields['expiration_date'] = time;
    request.fields['price'] = price.text;
    request.fields['quantity'] = availableAmount.text;
    request.fields['category_id'] = id;
    request.fields['periods'] = periodsString;
    print(name.text +
        time +
        price.text +
        availableAmount.text +
        id +
        periodsString);
    var response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 422) {
      EasyLoading.showError('invalid Credentials');
      return false;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  Future<bool> sendProduct() async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    if (await newProductCheck()) {
      EasyLoading.showSuccess('your product submitted successfully');
      return true;
    } else {
      print('error ');
      print('/n');
      EasyLoading.showError('message'); //put message
      return false;
    }
  }

  void sendAsJson() {
    final periods = [
      {
        'date': time3 == '?'
            ? time3 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time3,
        'sale': sale3.toString()
      },
      {
        'date': time2 == '?'
            ? time2 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time2,
        'sale': sale2.toString()
      },
      {
        'date': time1 == '?'
            ? time1 = DateFormat('yyyy-MM-dd').format(expirationDate!)
            : time1,
        'sale': sale1.toString()
      },
    ];

    periodsString = json.encode(periods);
    notifyListeners();
    print(periodsString);
    print('done formatting');
  }

  var message, token;

  void slider1(double newPrice) {
    sale1 = newPrice.round().toDouble();
    notifyListeners();
  }

  void dateTime1() {
    time1 = DateFormat("yyyy-MM-dd").format(expirationDate1!);
    notifyListeners();
  }

  void slider2(double newPrice) {
    if (newPrice.round().toDouble() > sale1) {
      sale2 = newPrice.round().toDouble();
    } else
      sale2 = sale1;

    notifyListeners();
  }

  void dateTime2() {
    time2 = DateFormat("yyyy-MM-dd").format(expirationDate2!);
    notifyListeners();
  }

  void slider3(double newPrice) {
    if (newPrice.round().toDouble() > sale2) {
      sale3 = newPrice.round().toDouble();
    } else
      sale3 = sale2;

    notifyListeners();
  }

  void dateTime3() {
    time3 = DateFormat("yyyy-MM-dd").format(expirationDate3!);
    notifyListeners();
  }
}
