import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/pages/home.dart';
import 'package:calories_tracker/pages/search_food.dart';
import 'package:calories_tracker/pages/add_food.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => home(),
        '/searchfood' : (context) => searchfood(),
        '/addfood': (context) => addfood(foodName: '',),
        '/date' : (context) => heatmap(),
      },
    )
);
