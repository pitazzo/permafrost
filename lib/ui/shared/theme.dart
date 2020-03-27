import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
    primarySwatch: Colors.indigo,
    textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'Baloo 2',
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.indigo),
        headline2:
            TextStyle(fontFamily: 'Baloo 2', fontSize: 40, color: Colors.black),
        headline3:
            TextStyle(fontFamily: 'Baloo 2', fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            color: Colors.indigo,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Baloo 2'),
        subtitle1: TextStyle(
            color: Colors.black54, fontSize: 15.0, fontFamily: 'Baloo 2'),
        bodyText2: TextStyle(
            color: Colors.black54, fontSize: 20.0, fontFamily: 'Baloo 2'),
        button: TextStyle(fontSize: 14, fontFamily: 'Baloo 2')));
