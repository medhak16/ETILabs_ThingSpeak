import 'package:flutter/material.dart';
import 'package:ui_thingspeak/screens/form.dart';
import 'package:ui_thingspeak/screens/write_form.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>MyHomePage(),
        '/home': (context) => MyHomePage(),
        '/form':(context)=>TestForm(),
        '/write_form':(context)=>WriteForm(),
      },
      initialRoute: '/',
    );
  }
}
