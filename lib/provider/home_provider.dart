import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zass/api/fetchsearchedproduct.dart';
import 'package:zass/api/reaction.dart';

class HomeProvider with ChangeNotifier {
  FetchSearchedData fetchData = FetchSearchedData();
  Reaction reactions = Reaction();

  String id = '0';

  bool like = false;

  void changeLike() {
    like = !like;
    notifyListeners();
  }

  Future<bool> logout() async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    if (await fetchData.logoutAuth()) {
      EasyLoading.showSuccess(
        'you logged out',
      );
      storage.delete();
      return true;
    } else {
      EasyLoading.showError('');
      return false; //put message
    }
  }

//  search

  var named;

  var priced;

  List listItem = ["Sports", "Technology", "Food", "Others"];

  DateTime? expirationDate;

  String time = '?';

  bool p = false;

  String names = 'zzzzzz', prices = '88888888', ids = '6', dates = '2100-1-1';

  String? valueChoosen;

  FetchSearchedData dataa = FetchSearchedData();

  var id1;

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

  void changeName(String v) {
    named = v;
    notifyListeners();
  }

  void changeCategory(Object? n) {
    valueChoosen = n as String?;
    notifyListeners();
  }

  void changePrice(String vi) {
    priced = vi;
  }

  void changeDate() {
    time = DateFormat('yyyy-MM-dd').format(expirationDate!);
    notifyListeners();
      }

  void editChanges() {
    if (named != null) {
      names = named;
    } else
      names = 'zzzzzz';

    if (priced != null) {
      prices = priced;
    } else
      prices = '88888888';

    if (id1 != null) {
      ids = id1;
    } else
      ids = '6';

    if (time != '?') {
      dates = time;
    } else if (time == '?') dates = '2100-1-1';

    p = true;
    EasyLoading.showSuccess('');
    print(names + prices + dates + ids);

    notifyListeners();
  }



///////////////**********************//////////////////////////////////////////
  /////add product
  // Future<bool> toHome(){

  // }

}
