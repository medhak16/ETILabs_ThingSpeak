import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/responseData.dart';
import 'package:ui_thingspeak/screens/form.dart';


class ResultPage extends StatefulWidget{

  ResponseData showRes;

  ResultPage({this.showRes});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>{

  @override
  Widget build(BuildContext context) {
    String name = widget.showRes.name;
    String description = widget.showRes.description;
    int id =widget.showRes.id;
    String field1_name =widget.showRes.field1_name;
    String field2_name=widget.showRes.field2_name;
    String field3_name=widget.showRes.field3_name;
    String create_date=widget.showRes.create_date;
    String update_date=widget.showRes.update_date;
    int lastId=widget.showRes.lastId;
    int entry0=widget.showRes.entry0;
    int entry1=widget.showRes.entry1;
    String feed0Creation =widget.showRes.feed0Creation ;
    String feed1Creation =widget.showRes.feed1Creation;
    var f10 =widget.showRes.f10;
    var f20 =widget.showRes.f20;
    var f30 =widget.showRes.f30;
    var f11 =widget.showRes.f11;
    var f21 =widget.showRes.f21;
    var f31 =widget.showRes.f31;
    print('CHECK:');
    var date=feed0Creation.substring(0,10);
    print(feed0Creation.substring(0,10));
    var d=DateTime.now();
    print(d.month);
    


    return Scaffold(
      appBar: AppBar(title: Text('Response')),
      body: SingleChildScrollView(
              child: Container(
          child:DataTable(
            columns: [
              DataColumn(label: Text('Key')),
              DataColumn(label: Text('Value'))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Channel Id')),
                DataCell(Text('$id'))
              ]),
              DataRow(cells: [
                DataCell(Text('Name')),
                DataCell(Text('$name'))
              ]),
              DataRow(cells: [
                DataCell(Text('Description')),
                DataCell(Text('$description'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field1 name')),
                DataCell(Text('$field1_name'))
              ]),
              DataRow(cells: [
                DataCell(Text('field2 name')),
                DataCell(Text('$field2_name'))
              ]),
              DataRow(cells: [
                DataCell(Text('field3 name')),
                DataCell(Text('$field3_name'))
              ]),
              DataRow(cells: [
                DataCell(Text('Created at')),
                DataCell(Text('$create_date'))
              ]),
              DataRow(cells: [
                DataCell(Text('Updated at')),
                DataCell(Text('$update_date'))
              ]),
              DataRow(cells: [
                DataCell(Text('Last Id')),
                DataCell(Text('$lastId'))
              ]),
              DataRow(cells: [
                DataCell(Text('Created at')),
                DataCell(Text('$feed0Creation'))
              ]),
              DataRow(cells: [
                DataCell(Text('Feed1 entry id')),
                DataCell(Text('$entry0'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 1')),
                DataCell(Text('$f10'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 2')),
                DataCell(Text('$f20'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 3')),
                DataCell(Text('$f30'))
              ]),
              DataRow(cells: [
                DataCell(Text('Feed2 entry id')),
                DataCell(Text('$entry1'))
              ]),
              DataRow(cells: [
                DataCell(Text('Created at')),
                DataCell(Text('$feed1Creation'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 1')),
                DataCell(Text('$f11'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 2')),
                DataCell(Text('$f21'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field 3')),
                DataCell(Text('$f31'))
              ]),
            ],
          ) ,
        ),
      ),
    );

  }

}