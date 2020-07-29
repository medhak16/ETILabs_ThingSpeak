import 'package:flutter/material.dart';
import 'package:ui_thingspeak/constant.dart';
import '../constant.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/screens/form.dart';
import 'package:ui_thingspeak/screens/write_form.dart';
import 'package:ui_thingspeak/services/database_services.dart';

import 'form.dart';
import 'write_form.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.check_box_outline_blank),
                text: 'Channel',
              ),
              Tab(
                icon: Icon(Icons.chrome_reader_mode),
                text: 'Read',
              ),
              Tab(
                icon: Icon(Icons.edit),
                text: 'Write',
              ),
            ],
          ),
          title: Text(
            'ThingSpeak',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        // backgroundColor: Colors.black,
        body: TabBarView(
            children: <Widget>[HomeScreen(), TestForm(), WriteForm()]),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String channelId;
  String readKey;
  String writeKey;

  Model model = Model();
  DatabaseService _databaseService = DatabaseService();
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
      
        children: <Widget>[
          SizedBox(height: 20.0,),
          MyTextFormField(
            hintText: 'Channel Id',
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a channel id';
              }
              return null;
            },
            onChange: (value) {
              setState(() {
                channelId = value;
              });
             
            },
          ),
          SizedBox(height: 15.0),
          MyTextFormField(
            hintText: 'Read Key',
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a Read key';
              }
              return null;
            },
            onChange: (value) {
              model.r_key=value;
              setState(() {
                readKey = value;
              });
            },
          ),
          SizedBox(height: 15.0),
          MyTextFormField(
            hintText: 'Write Key',
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a Write key';
              }
              return null;
            },
            onChange: (value) {
              model.w_key=value;
              setState(() {
                writeKey = value;
              });
            },
          ),
          SizedBox(height: 15.0),
          FlatButton(
            onPressed: ()  {
              _databaseService.addChannelID(channelId: channelId );
              _databaseService.addReadKey(mReadKey: readKey);
              _databaseService.addWriteKey(mWriteKey: writeKey);
              showAlertDialog(context);
            },
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(18.0)),
              child: Text(
                'Save Credentials',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Credentials Saved!"),
      content: Text('Now you can read or write using above tabs'),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
