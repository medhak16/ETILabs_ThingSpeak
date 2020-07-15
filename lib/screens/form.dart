import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/screens/result.dart';
import 'package:ui_thingspeak/screens/result_field.dart';
import 'package:ui_thingspeak/services/network.dart';
import 'package:ui_thingspeak/model/responseData.dart';
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Model model = Model();
  ResponseData showRes = ResponseData();
  NetworkService _networkService = NetworkService();

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
                            model.apiKey = value;
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
                  hintText: 'Channel id',
                  /*validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter a channel id';
                    }
                    return null;
                  },*/
                  onChange: (value) {
                    model.channelId = value;
                  },
                ),
                FlatButton(
                  color: Colors.green,
                  onPressed: () async {
                    var response;
                    setState(() {
                      _isLoading = true;
                    });
                    //read call function

                      if(model.field !=null){
                          response = await _networkService.getResponseUsingFieldValue(
                        channelId: model.channelId, apiKey: model.apiKey,fieldValue: model.field);
                      }
                      else{
                         response = await _networkService.getAllResponseAtOnce(
                        channelId: model.channelId, apiKey: model.apiKey);
                      }
                    if (response != null) {
                      var field = model.field;
                      print('response: $response');
                      var recData = jsonDecode(response);
                      debugPrint('Recdata is: $recData');
                      int id = recData['channel']['id'];
                      String name = recData['channel']['name'];
                      String description = recData['channel']['description'];
                      String field1_name = recData['channel']['field1'];
                      String field2_name = recData['channel']['field2'];
                      String field3_name = recData['channel']['field3'];
                      String create_date = recData['channel']['created_at'];
                      String update_date = recData['channel']['updated_at'];
                      int lastId = recData['channel']['last_entry_id'];
                      int entry0 = recData['feeds'][0]['entry_id'];
                      int entry1 = recData['feeds'][1]['entry_id'];
                      String feed0Creation =recData['feeds'][0]['created_at'];
                      String feed1Creation =recData['feeds'][1]['created_at'];
                      var f10 = recData['feeds'][0]['field1'];
                      var f20 = recData['feeds'][0]['field2'];
                      var f30 = recData['feeds'][0]['field3'];
                      var f11 = recData['feeds'][1]['field1'];
                      var f21 = recData['feeds'][1]['field2'];
                      var f31 = recData['feeds'][1]['field3'];

                      var feild_column1 = recData['feeds'][0]['field$field'];
                      var feild_column2 = recData['feeds'][1]['field$field'];

                      debugPrint('sending : $feild_column1');

                      //print('$name');
                      showRes.id = id;
                      showRes.name = name;
                      showRes.description = description;
                      showRes.field1_name = field1_name;
                      showRes.field2_name = field2_name;
                      showRes.field3_name = field3_name;
                      showRes.create_date = create_date;
                      showRes.update_date = update_date;
                      showRes.lastId = lastId;
                      showRes.entry0 = entry0;
                      showRes.entry1 = entry1;
                      showRes.feed0Creation= feed0Creation;
                      showRes.feed1Creation =feed1Creation;
                      showRes.f10 = f10;
                      showRes.f20 = f20;
                      showRes.f30 = f30;
                      showRes.f11 = f11;
                      showRes.f21 = f21;
                      showRes.f31 = f31;
                      setState(() {
                        _isLoading = false;
                      });

                     if(model.field == null){
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                   ResultPage(showRes: this.showRes)));
                     }
                     else{
                       print('in navigator: field $field');
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                   FieldResultPage(showRes: this.showRes, feild: model.field, feild_column1: feild_column1, feild_column2:feild_column2)));
                     }
                      //Navigator.pushNamed(context, model.field == null ? '/result' : '/result_field');
                    } else {
                      print('response error');
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: Text(
                    'Read',
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
