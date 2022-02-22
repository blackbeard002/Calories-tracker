import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/pages/home.dart';
import 'package:calories_tracker/widgets/searchTest.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => home(),
        '/search' : (context) => searchFoods(),
        '/date' : (context) => heatmap(),
      },
    )
);
