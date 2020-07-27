import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  void addChannelID({String channelId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("channelId", channelId);
  }

  void addReadKey({String mReadKey}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("readKey", mReadKey);
  }

  void addWriteKey({String mWriteKey}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("writeKey", mWriteKey);
  }

  getChannelId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString("channelId");
    return stringValue;
  }

  getReadKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString("readKey");
    return stringValue;
  }

  getWriteKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString("writeKey");
    return stringValue;
  }
}
