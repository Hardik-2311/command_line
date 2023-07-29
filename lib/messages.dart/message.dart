// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:discord/models/user_create.dart';
import 'package:discord/exceptions/exceptions.dart';

class message extends Exception {
  Future<void> channel_msg(
      Database db2,
      Database db3,
      Database db4,
      StoreRef<String, Map> server_store,
      StoreRef<String, Map> channel_store,
      StoreRef<Map, Map> message_store,
      User user1) async {
    if (await super.logged_in(user1)) {
      return;
    } else {
      final String username = user1.username;
      stdout.write("In which channel do you want to message: ");
      String channelName = stdin.readLineSync() as String;
      Map? channel = await channel_store.record(channelName).get(db3);
      if (channel == null) {
        print("channel is not in the server");
        return;
      }
      bool flag2 = false;
      var channel_type;
      for (var user_name in channel['mememberlist']) {
        if (user_name == username) {
          flag2 = true;
          channel_type = channel['type'];
        }
      }
      if (!flag2) {
        print("The user is not in the given channel");
        return;
      } else {
        stdout.write("Enter the message-> ");
        String message = stdin.readLineSync() as String;
        Map message_key = {'channel_name': channelName};
        Map message_value = {'user': username, 'message': message};
        await message_store.record(message_key).put(db4, message_value);
        print("Message sent successfully");
      }
    }
  }

  personalDm(Database db5, Database db1, StoreRef<Map, String> p_dm_store,
      StoreRef<String, String> user_store, User user1) async {
    late final sender;
    late final receiver;
    late final msg;
    if (await super.logged_in(user1)) {
      return;
    } else {
      stdout.write("Name of the person you want ot send the message-> ");
      receiver = stdin.readLineSync();
      //check the server is registered or not
      if (!(await super.registered(receiver, db1, user_store, user1))) {
        print("No user exists");
        return;
      } else {
        sender = user1.username;
        stdout.write("Message-> ");
        msg = stdin.readLineSync();
        Map Dm = {
          'sender': sender,
          'receiver': receiver,
        };
        await p_dm_store.record(Dm).put(db5, msg);
        print("Message sent successfully");
      }
    }
  }
}
