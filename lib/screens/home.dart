import 'package:flutter/material.dart';
import 'package:ui_thingspeak/constant.dart';
import 'package:ui_thingspeak/screens/result.dart';
import '../constant.dart';
import 'package:ui_thingspeak/screens/form.dart';
import 'package:ui_thingspeak/screens/write_form.dart';
import 'package:ui_thingspeak/model/data_model.dart';

import 'form.dart';
import 'write_form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
          child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(  
        tabs: [  
          Tab(icon: Icon(Icons.check_box_outline_blank),text: 'Channel',),  
          Tab(icon: Icon(Icons.chrome_reader_mode),text: 'Read',), 
          Tab(icon: Icon(Icons.edit),text: 'Write',), 
           ],),
          title: Text(
            'ThingSpeak',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        
       // backgroundColor: Colors.black,
        body: TabBarView(
          children:<Widget>[
            HomeScreen(),
            TestForm(),
            WriteForm()

          ] ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {

  const HomeScreen({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(20.0),
        //shadowColor: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MyTextFormField(
              hintText: 'Channel Id',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter a channel id';
                }
                return null;
              },
              onChange: (value) {
                model.channelId = value;
              },
            ),
            SizedBox(height: 15.0),
            MyTextFormField(
              hintText: 'Read Key',
              validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a Read key';
                    }
                    return null;
                  },
              onChange: (value) {
                model.readKey = value;
              },
            ),
            SizedBox(height: 15.0),
            MyTextFormField(
              hintText: 'Write Key',
              validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a Write key';
                    }
                    return null;
                  },
              onChange: (value) {
                model.writeKey = value;
              },
            ),
            SizedBox(height: 15.0),
            FlatButton(
              color: Colors.blueGrey,
              onPressed: () => print('hello'),
              child: Text('Read Channel',
              style: TextStyle(
                color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onChange;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onChanged: onChange,
      ),
    );
  }
}
