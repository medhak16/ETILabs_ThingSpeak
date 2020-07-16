import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/screens/result.dart';
import 'package:ui_thingspeak/services/network.dart';
import 'dart:convert';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'API key',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter the API key';
                          }
                          return null;
                        },
                        onChange: (value) {
                         // model.apiKey = value;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'Field id',
                        /*validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter the field name';
                            }
                            return null;
                          },*/
                        onChange: (value) {
                          model.field = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              MyTextFormField(
                hintText: 'Enter Data Value',
                /*validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a channel id';
                    }
                    return null;
                  },*/
                onChange: (value) {
                  model.data = value;
                },
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () async {
                  var response;
                  setState(() {
                    _isLoading = true;
                  });
                  //write call function
                  debugPrint('Data added ');
                  // response = await _networkService.writeInField(
                  //     apiKey: model.apiKey,
                  //     fieldValue: model.field,
                  //     data: model.data);

                  if (response != null) {
                    print('response: $response');
                    var recData = jsonDecode(response);
                    model.response = recData;
                    showAlertDialog(context, res: model.response);
                    //debugPrint('Response is : $recData');
                    setState(() {
                      _isLoading = false;
                    });
                  } else {
                    print('response error');
                    setState(() {
                      _isLoading = false;
                    });
                  }
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

  void showAlertDialog(BuildContext context, {var res}) {
    // set up the button
    Widget homeButton = FlatButton(
      child: Text("Home"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/home');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Entry Added!"),
      content: Text("Entry id: $res "),
      actions: [
        homeButton,
      ],
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
