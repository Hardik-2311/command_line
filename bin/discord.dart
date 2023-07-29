// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:discord/messages.dart/message.dart';
import 'package:sembast/sembast.dart';
import 'package:discord/models/storage.dart';
import 'package:discord/models/user_create.dart';
import 'package:discord/models/server.dart';
import 'package:discord/models/channel.dart';

void main() async {
  var storage = Storage.constructor1();
  User new_user = User("0", "0");
  var fun = Admin.fun();
  var server = Server();
  var channel = Channel();
  var message1=message();

  List<dynamic> myList = await storage.connection();
  Database db1 = myList[0];
  Database db2 = myList[1];
  Database db3 = myList[2];
  Database db4 = myList[3];
  Database db5 = myList[4];
  StoreRef<String, String> userStore = myList[5];
  StoreRef<String, Map> server_store = myList[6];
  StoreRef<String, Map> channel_store = myList[7];
  StoreRef<Map, Map> message_store= myList[8];
  StoreRef<Map,String> p_dm_store=myList[9];

 
  var server_record = myList[11];
  var channel_record = myList[12];
  var message_record=myList[13];


  bool flag = true;

  while (flag) {
    stdout.write('>> ');
    var input = stdin.readLineSync() as String;

    switch (input) {
      case "register":
        await fun.register(db1, userStore, new_user);
        break;

      case "login":
        await fun.login(db1, userStore, new_user);
        break;

      case "logout":
        await fun.logout(new_user);
        break;

      case "delete":
        await fun.deleteData(db1, userStore, new_user);
        break;

      case "createserver":
        await server.createServer(db2, server_store, new_user, server_record);
        break;

      case "joinserver":
        await server.joinSerever(db2, server_store, new_user, server_record);
        break;

      case "createChannel":
        await channel.create_channel(db2, db3, channel_store, server_store, new_user, channel_record, server_record);
        break;

      case "sendmessagetochannel":
      await message1.channel_msg(db2, db3, db4, server_store, channel_store, message_store, new_user);
      break;

      case "sendDm":
      await message1.personalDm(db5, db1, p_dm_store, userStore, new_user);
      break;

      case "exit":
        flag = false;

      default:
        print("not a valid command");
    }
  }
  await db1.close();
  await db2.close();
  await db3.close();
  // await db4.close();
  // await db5.close();
}
