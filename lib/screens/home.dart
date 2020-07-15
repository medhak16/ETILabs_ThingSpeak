import 'package:flutter/material.dart';
import 'package:ui_thingspeak/constant.dart';
import 'package:ui_thingspeak/screens/result.dart';
import '../constant.dart';
import 'package:ui_thingspeak/screens/form.dart';
import 'package:ui_thingspeak/screens/write_form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ThingSpeak', style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.all(20.0),
          //shadowColor: Colors.lightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             /* Container(
                child: Center(
                  child: Text('Here we have some content'),
                ),
              ),*/
              //SizedBox(height:10.0),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/write_form');
                },
                color: Colors.black38,
                child: Text('Write', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height:30.0),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/form');
                },
                color: Colors.black38,
                child: Text('Read', style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
