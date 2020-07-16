import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/data_model.dart';
import 'package:ui_thingspeak/services/network.dart';
import 'package:ui_thingspeak/model/responseData.dart';
import 'package:ui_thingspeak/constant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:ui_thingspeak/services/database_services.dart';

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

  Future getDataCards() async {
     List<ReadContainer> feildCards = [];
    var dataResponse = await _networkService.getAllResponseAtOnce(
        channelId: channelId, readKey: readKey);
   
    var recData =  jsonDecode(dataResponse);
    String name = recData['channel']['name'];
    String field1 = recData['channel']['field1'];
    print(recData);

    for (int i = 1; i < 8; i++) {
      String field = recData['channel']['field$i'];
      var dataCard = ReadContainer(
        feildData: field,
      );
      feildCards.add(dataCard);
      print(field);
    }
    return feildCards;
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
  ReadContainer({this.feildData});

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
                      child: Text(
                'Feild 1',
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
                  '$feildData',
                  style: kReadDataStyle,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () => print('graph'),
            child: Text('Graph'),
          )
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

//  FlatButton(
//                   color: Colors.green,
//                   onPressed: () async {

//                     setState(() {
//                       _isLoading = true;
//                     });
//                     //read call function

//                     //   if(model.field !=null){
//                     //       response = await _networkService.getResponseUsingFieldValue(
//                     //     channelId: model.channelId, apiKey: model.apiKey,fieldValue: model.field);
//                     //   }
//                     //   else{
//                     //      response = await _networkService.getAllResponseAtOnce(
//                     //     channelId: model.channelId, apiKey: model.apiKey);
//                     //   }
//                     // if (response != null) {
//                       // var field = model.field;
//                       // print('response: $response');
//                       // var recData = jsonDecode(response);
//                       // debugPrint('Recdata is: $recData');
//                       // int id = recData['channel']['id'];
//                       // String name = recData['channel']['name'];
//                       // String description = recData['channel']['description'];
//                       // String field1_name = recData['channel']['field1'];
//                       // String field2_name = recData['channel']['field2'];
//                       // String field3_name = recData['channel']['field3'];
//                       // String create_date = recData['channel']['created_at'];
//                       // String update_date = recData['channel']['updated_at'];
//                       // int lastId = recData['channel']['last_entry_id'];
//                       // int entry0 = recData['feeds'][0]['entry_id'];
//                       // int entry1 = recData['feeds'][1]['entry_id'];
//                       // String feed0Creation =recData['feeds'][0]['created_at'];
//                       // String feed1Creation =recData['feeds'][1]['created_at'];
//                       // var f10 = recData['feeds'][0]['field1'];
//                       // var f20 = recData['feeds'][0]['field2'];
//                       // var f30 = recData['feeds'][0]['field3'];
//                       // var f11 = recData['feeds'][1]['field1'];
//                       // var f21 = recData['feeds'][1]['field2'];
//                       // var f31 = recData['feeds'][1]['field3'];

//                       // var feild_column1 = recData['feeds'][0]['field$field'];
//                       // var feild_column2 = recData['feeds'][1]['field$field'];

//                       // debugPrint('sending : $feild_column1');

//                       // //print('$name');
//                       // showRes.id = id;
//                       // showRes.name = name;
//                       // showRes.description = description;
//                       // showRes.field1_name = field1_name;
//                       // showRes.field2_name = field2_name;
//                       // showRes.field3_name = field3_name;
//                       // showRes.create_date = create_date;
//                       // showRes.update_date = update_date;
//                       // showRes.lastId = lastId;
//                       // showRes.entry0 = entry0;
//                       // showRes.entry1 = entry1;
//                       // showRes.feed0Creation= feed0Creation;
//                       // showRes.feed1Creation =feed1Creation;
//                       // showRes.f10 = f10;
//                       // showRes.f20 = f20;
//                       // showRes.f30 = f30;
//                       // showRes.f11 = f11;
//                       // showRes.f21 = f21;
//                       // showRes.f31 = f31;
//                       setState(() {
//                         _isLoading = false;
//                       });

//                      if(model.field == null){
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) =>
//                                    ResultPage(showRes: this.showRes)));
//                      }
//                      else{
//                       // print('in navigator: field $field');
//                       //  Navigator.push(
//                       //      context,
//                       //      MaterialPageRoute(
//                       //          builder: (context) =>
//                       //              FieldResultPage(showRes: this.showRes, feild: model.field, feild_column1: feild_column1, feild_column2:feild_column2)));
//                      }
//                       //Navigator.pushNamed(context, model.field == null ? '/result' : '/result_field');
//                     // } else {
//                     //   print('response error');
//                     //   setState(() {
//                     //     _isLoading = false;
//                     //   });
//                     // }
//                   },
//                   child: Text(
//                     'Read',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 )

//  Container(
//                   height: 250,
//                   decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black,width: 2.0),
//                     color: Colors.blueAccent.withOpacity(0.50),
//                   ),
//                   margin: EdgeInsets.all(2.5),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
//                     child: Center(child: Text('Graph',style: TextStyle(color: Colors.black,backgroundColor: Colors.white),)),

//                   ),
//                 ),

// ListView(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Things Speak',
//                 style: kTextFeildHeadings,
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               RaisedButton(
//                   onPressed: () async {},
//                   child: Text(
//                     'READ',
//                     style: kTextForHomeButtons,
//                   )),
//             ],
//           ),
//           Column(
//             children: feildCards,
//           )
//         ],
//       ),
