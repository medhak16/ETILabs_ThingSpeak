import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/services/network.dart';
//import 'package:ui_thingspeak/model/responseData.dart';
import 'package:ui_thingspeak/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:ui_thingspeak/services/database_services.dart';
import 'package:url_launcher/url_launcher.dart';

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  NetworkService _networkService = NetworkService();
  DatabaseService _databaseService = DatabaseService();

  String channelId;
  String readKey;

  void extractCredentials() async {
    var mChannel = await _databaseService.getChannelId();
    var mreadKey = await _databaseService.getReadKey();
    setState(() {
      channelId = mChannel;
      print(mreadKey);
      readKey = mreadKey;
    });
  }

 
  Future getDataCards() async {
    List<ReadContainer> feildCards = [];
    var dataResponse = await _networkService.getAllResponseAtOnce(
        channelId: channelId, readKey: readKey);

    try {
      var recData = await jsonDecode(dataResponse);
      String name = recData['channel']['name'];
    String field1 = recData['channel']['field1'];
    print(recData);

    for (int i = 1; i < 8; i++) {
      String field = recData['channel']['field$i'];
      var value1 = recData['feeds'][0]['field$i'];
      var value2 = recData['feeds'][1]['field$i'];

      var dataCard = ReadContainer(
        feildData: field,
        feedValue1: value1,
        feedValue2: value2,
        channelId: channelId,
        fieldNum: i,
        api_key: readKey,

      );
      feildCards.add(dataCard);
      print(field);
    }
    return feildCards;
    } catch (e) {
      print(e.toString());
    }
    
  }

  @override
  void initState() {
    extractCredentials();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Container(
      child: FutureBuilder(
          future: getDataCards(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data,
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('Loading please wait..'),
                ),
              );
            }
          }),
    );
  }
}

class ReadContainer extends StatelessWidget {
  final String feildData;
  var feedValue1, feedValue2;
  String channelId;
  int fieldNum;
  String api_key;
  ReadContainer({this.feildData, this.feedValue1,this.feedValue2, this.channelId,this.fieldNum,this.api_key});

  @override
  Widget build(BuildContext context) {
    return feildData==null?Container() : Container(
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
                      child: Text(
                '$feildData',
                style: kTextFeildHeadings,
              )))),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.50),
              ),
              margin: EdgeInsets.all(2.5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  '$feedValue1 , $feedValue2',
                  style: kReadDataStyle,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              print('inside button');
              /*WebView(
                initialUrl: 'https://www.google.com/',
                  javascriptMode: JavascriptMode.unrestricted,
              );*/
              launchURL(channelId: channelId, fieldNum: fieldNum, key: api_key);
            },
            child: Text('Graph'),
          )
        ],
      ),
    );
  }

  void launchURL({String channelId, int fieldNum, var key }) async{
    debugPrint('testing : $channelId and $fieldNum and $key');
    String url = 'https://thingspeak.com/channels/$channelId/charts/$fieldNum?api_key=$key&bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15';
    if(await canLaunch(url)){
      print(url);
      await launch(url);
    }
    else{
      throw 'could not launch $url';
    }
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

