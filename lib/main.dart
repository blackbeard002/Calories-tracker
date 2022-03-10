import 'package:calories_tracker/pages/edit_page.dart';
import 'package:calories_tracker/pages/login_reg.dart';
import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/pages/home.dart';
import 'package:calories_tracker/pages/search_food.dart';
import 'package:calories_tracker/pages/add_food.dart';
import 'package:calories_tracker/pages/flash_screen.dart';

void main() => runApp(MaterialApp(
      //initialRoute: '/searchfood',
      routes: {
        '/' : (context) => flashscreen(),
        '/loginReg': (context) => loginPage(),
        '/edit' : (context) => editDelegate(),
        '/home': (context) => home(),
        '/searchfood' : (context) => searchfood(selectedDate: DateTime.now(),),
        '/addfood': (context) => addfood(foodName: '', selectedDate: DateTime.now(),),
        '/date' : (context) => heatmap(),
      },
    )
);
