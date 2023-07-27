// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:discord/models/storage.dart';
import 'package:discord/models/user_create.dart';
import 'package:discord/models/server.dart';
void main() async {
  var storage = Storage.constructor1();
  User new_user = User("0", "0");
  var fun = Admin.fun();
  var server=Server();

  List<dynamic> myList = await storage.connection();
  Database db1 = myList[0];
  Database db2 = myList[1];
  Database db3 = myList[2];
  Database db4 = myList[3];
  Database db5 = myList[4];
  StoreRef<String, String> userStore = myList[5];
  StoreRef<String, Map> server_store = myList[6];

  var server_record = myList[7];

  bool flag = true;

  while (flag) {
    stdout.write('>>');
    var input = stdin.readLineSync() as String;

    switch (input) {
      case "register":
        await fun.register(db1, userStore, new_user);
        break;

      case "login":
        await fun.login(db1, userStore, new_user);

      case "logout":
        await fun.logout(new_user);

      case "delete":
        await fun.deleteData(db1, userStore, new_user);

      case "createserver":
      await server.createServer(db2, server_store, new_user, server_record);

      case "joinserver":
              await server.joinSerever(
                  db2, server_store, new_user, server_record);
              break;

      case "exit":
        flag = false;

      default:
        print("not a valid command");
    }
  }
  await db1.close();
  await db2.close();
  // await db3.close();
  // await db4.close();
  // await db5.close();
}
