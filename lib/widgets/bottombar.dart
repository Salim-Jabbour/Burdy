//done

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zass/provider/add_product_provider.dart';
import 'package:zass/provider/bottom_bar_provider.dart';
import 'package:zass/provider/home_provider.dart';
import 'package:zass/widgets/addProduct.dart';
import 'package:zass/null/utils.dart';
import 'package:zass/widgets/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'category.dart';
import 'home.dart';
import 'profile.dart';

class BottomBar extends StatelessWidget {
  List<Widget> _bottomBarOptions = <Widget>[
    Home(), //Home
    Search(),
    MyAddNewProductPage(),
    Category(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    final bottombarprovider = Provider.of<BottomBarProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ), ChangeNotifierProvider(
          create: (context) => AddProductProvider(),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.deepOrange,
          style: TabStyle.react,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.search, title: 'Search'),
            TabItem(icon: Icons.add_shopping_cart_rounded, title: 'Add'),
            TabItem(icon: Icons.category, title: 'Category'),
            TabItem(icon: Icons.account_circle, title: 'Profile'),
          ],
          initialActiveIndex:
              bottombarprovider.currentIndex, //optional, default as 0
          onTap: bottombarprovider.changeItem,
        ),
        body: _bottomBarOptions.elementAt(bottombarprovider.currentIndex),
      ),
    );
  }
}
