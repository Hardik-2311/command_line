import 'dart:io';
import 'package:discord/exceptions/exceptions.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';
import 'user_create.dart';
import '../enums/enums.dart';

class Channel extends Exception {
  late String name;
  late ChannelType type;
  late String server;
  late List<String> memberlist;
  late String category;
   create_channel(
    Database db2,
    Database db3,
    StoreRef<String, Map> channel_store,
    StoreRef<String, Map> server_store,
    User user1,
    var channel_record,
    var server_record,
  ) async {
    //check if the user has logged in or not

    if (await super.logged_in(user1)) {
      return;
    } else {
      //taking input which server you want your channel to be in

      stdout.write("which server you want to join? -> ");
      final serverName = stdin.readLineSync() as String;
      if (await super.no_any_server_exist(serverName, db2, server_store)) {
        return;
      }
      stdout.write("Enter the Channel Name:");
      final channelName = stdin.readLineSync() as String;
      this.name = channelName;
      var c_record = await server_store.find(db3);
      for (var rec in c_record) {
        if (rec.key == channelName && rec.value['server_name'] == serverName) {
          for (var user in rec.value['memberlist']) {
            if (user == user1.username) {
              print("User is already in the channel");
              return;
            }
          }
          Map channel_list =
              await channel_store.record(channelName).get(db3) as Map;
          channel_list = cloneMap(channel_list); //Create a copy of the map
          channel_list['memberlist'].add(user1.username);
          await channel_store.record(channelName).delete(db3);
          await channel_store.record(channelName).put(db3, channel_list);
          print("Channel added successfully");
          return;
        }
      }
    }
  }
}
