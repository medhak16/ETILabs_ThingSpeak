import 'package:flutter/material.dart';
import 'package:ui_thingspeak/model/responseData.dart';
import 'package:ui_thingspeak/screens/form.dart';

class FieldResultPage extends StatelessWidget {
  ResponseData showRes;
  //var responseData;
  var feild;
  var feild_column1;
  var feild_column2;

  FieldResultPage(
      {this.showRes, this.feild, this.feild_column1, this.feild_column2});

  @override
  Widget build(BuildContext context) {
    int field = int.parse(feild);
    String name = showRes.name;
    String description = showRes.description;
    int id = showRes.id;
    String field1_name = showRes.field1_name;
    String field2_name = showRes.field2_name;
    String field3_name = showRes.field3_name;
    String create_date = showRes.create_date;
    String update_date = showRes.update_date;
    int lastId = showRes.lastId;
    int entry0 = showRes.entry0;
    int entry1 = showRes.entry1;
    String feed0Creation = showRes.feed0Creation;
    String feed1Creation = showRes.feed1Creation;
    var f10 = showRes.f10;
    var f20 = showRes.f20;
    var f30 = showRes.f30;
    var f11 = showRes.f11;
    var f21 = showRes.f21;
    var f31 = showRes.f31;

    return Scaffold(
      appBar: AppBar(title: Text('Response')),
      body: SingleChildScrollView(
        child: Container(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Key')),
              DataColumn(label: Text('Value'))
            ],
            rows: [
              DataRow(
                  cells: [DataCell(Text('Channel Id')), DataCell(Text('$id'))]),
              DataRow(cells: [DataCell(Text('Name')), DataCell(Text('$name'))]),
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
                DataCell(Text('Feed1 entry id')),
                DataCell(Text('$entry0'))
              ]),
              DataRow(cells: [
                DataCell(Text('Created at')),
                DataCell(Text('$feed0Creation'))
              ]),
              DataRow(cells: [
                DataCell(Text('Field $field')),
                DataCell(Text('$feild_column1'))
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
                DataCell(Text('Field $field')),
                DataCell(Text('$feild_column2'))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
