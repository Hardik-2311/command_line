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
    if(await super.logged_in(user1)){
      return;
    }
      //taking input which server you want your channel to be in

      stdout.write("which server you want to join? -> ");
      final serverName = stdin.readLineSync() as String;
      if (await super.no_any_server_exist(serverName, db2, server_store)) {
        return;
      }
      stdout.write("Enter the Channel Name:");
      final channelName = stdin.readLineSync() as String;
      this.name = channelName;
      stdout.write("Channel Type:[text/voice/announcement/hackathons]: ");
      final channeltype = stdin.readLineSync() as String;

      switch (channeltype) {
        case "text":
          this.type = ChannelType.text;
          break;
        case "voice":
          this.type = ChannelType.text;
          break;
        case "announcements":
          this.type = ChannelType.text;
          break;
        case "hackathons":
          this.type = ChannelType.text;
          break;
        default:
          print("Invalid input");
          return;
      }
      Map<String, dynamic> s_map = {
        'server_name': serverName,
        'mememberlist': [user1.username],
        'type': channeltype,
      };
      await channel_store.record(channelName).put(db3, s_map);
      //for adding channel in server.db if category is null
      Map pr = await server_store.record(serverName).get(db2) as Map;
      pr = cloneMap(pr); // Create a copy of the map
      pr['channellist'].add(channelName);
      await server_store.record(serverName).delete(db2);
      await server_store.record(serverName).put(db2, pr);
      print('User added to the channel successfully');
    
  }
}
