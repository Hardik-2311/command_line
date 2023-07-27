//serevr exists
//channel exists
//already login
//already registered
//category exists
import 'package:sembast/sembast.dart';
import 'package:discord/models/user_create.dart';

class Exception {
  //for checking user is registered or not

  Future<bool> registered(String receiver, Database db1,
      StoreRef<String, String> userStore, User user1) async {
    //if bool is true user is registered
    var record = await userStore.find(db1); //to find in the database
    bool output = false;

    for (var i in record) {
      if (i.key == receiver) {
        output = true;
      }
    }
    if (output) {
      return true;
    } else {
      return false;
    }
  }

  //user logged in
  Future<bool> logged_in(User user1) async {
    if (user1.username == "0") {
      print("Login First");
      return true;
    }
    return false;
  }

  //server Exists

  Future<bool> server_exist(String serverName, Database db2,
      StoreRef<String, Map> server_store) async {
    var server_record = await server_store.find(db2);
    for (var i in server_record) {
      if (i.key == serverName) {
        print("Server exists");
        return true;
      }
    }
    return false;
  }

  Future<bool> no_any_server_exist(
    String servername, Database db2, StoreRef<String, Map> server_store) async {
    bool flag = false;
    var server_record = await server_store.find(db2);
    for (var rec in server_record) {
      if (rec.key == servername) {
        flag = true;
      }
    }
    if (!flag) {
      print("No server with such name exists");
      return true;
    }
    return false;
  }
}
