import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkService {
//Make a function to READ-ALL fields @ApiKey @channelID
  Future<String> getAllResponseAtOnce({String channelId, String readKey}) async {
    //https://api.thingspeak.com/channels/1095647/feeds.json?api_key=S9MEVAKVC879GYZQ&results=2
    String url =
        'https://api.thingspeak.com/channels/$channelId/feeds.json?api_key=$readKey&results=2';
    //print(url);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var responseBody = res.body;
      print(responseBody);
      return responseBody;
    } else {
      print(res.statusCode);
      print('Somehow things went wrong!!');
      return null;
    }
  }

  Future getResponseUsingFieldValue({String channelId, String apiKey, String fieldValue}) async {

    //https://api.thingspeak.com/channels/1095647/fields/1.json?api_key=S9MEVAKVC879GYZQ&results=2
     String url = 'https://api.thingspeak.com/channels/$channelId/fields/$fieldValue.json?api_key=$apiKey&results=2';
     print(url);
     var res = await http.get(url);
     if (res.statusCode == 200) {
       var responseBody = res.body;
       print(responseBody);
       return responseBody;
     }
     else {
       print(res.statusCode);
       print('Somehow things went wrong!!');
       return null;
     }
  }

  //Make a function to Write-IN using @ApiKey @FieldId @dataToWrite
  Future writeInField ({String writeKey, String fieldValue, var data}) async {
     //debugPrint('data is: $data');
     String url = 'https://api.thingspeak.com/update?api_key=$writeKey&field$fieldValue=$data';
     print(url);
     var res = await http.get(url);
     if(res.statusCode==200){
       var responseBody= res.body;
       print(responseBody);
       return responseBody;
     }
     else{
      print(res.statusCode);
      print('Somehow things went wrong!!');
      return null;
     }
   }

}
