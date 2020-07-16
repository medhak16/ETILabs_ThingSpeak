import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/screens/result.dart';
import 'package:ui_thingspeak/services/network.dart';
import 'dart:convert';
import 'package:ui_thingspeak/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui_thingspeak/services/database_services.dart';

class WriteForm extends StatefulWidget {
  @override
  _WriteFormState createState() => _WriteFormState();
}

class _WriteFormState extends State<WriteForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Model model = Model();
  NetworkService _networkService = NetworkService();
  DatabaseService _databaseService = DatabaseService();

  String channelId;
  String readKey;

  void extractCredentials() async {
    var mChannel = await _databaseService.getChannelId();
    var mreadKey = await _databaseService.getReadKey();
    setState(() {
      channelId = mChannel;
      readKey = mreadKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            
            children: <Widget>[
             WriteContainer(),
             WriteContainer(),
             WriteContainer(),
             WriteContainer(),
             WriteContainer(),
             WriteContainer(),
              RaisedButton(
                color: Colors.green,
                onPressed: () async {

                },
                child: Text(
                  'write',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class WriteContainer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        decoration:
      BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
          flex: 1,
          child: Container(
              child: Center(
                  child:Text('Feild 1')
          ),),),
      Expanded(
        flex: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.50),
          ),
          margin: EdgeInsets.all(2.5),
          child: MyTextFormField(
          hintText: 'Enter Data Value',
         
          onChange: (value) {
          //model.data = value;
          },
        ),
          ),
        ),
     
    ],
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
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(15.0),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: validator,
      onChanged: onChange,
    );
  }
}
