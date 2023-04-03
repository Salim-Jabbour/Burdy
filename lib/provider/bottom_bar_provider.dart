
import 'package:flutter/material.dart';

class BottomBarProvider with ChangeNotifier{

  int currentIndex=0;

void changeItem(int value){
      currentIndex = value;
    notifyListeners();
    
  }

}