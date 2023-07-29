// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:discord/exceptions/exceptions.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';
import 'user_create.dart';
import '../enums/enums.dart';

class Server extends Exception {
  late String name;
  late List<Map<String, dynamic>> memberlist;
  late ServerType role;
  late List<Map<String, dynamic>> categorylist;

  Future? createServer(Database db2, StoreRef<String, Map> server_store,
      User user1, var server_record) async {
    if (await super.logged_in(user1)) {
      return;
    } else {
      stdout.write("Name of the server -> ");
      final servername = stdin.readLineSync() as String;
      this.name = servername;
      if (await super.server_exist(servername, db2, server_store)) {
        return;
      }
      stdout.write("Type password with which users can access mod role -> ");
      stdin.echoMode = false;
      final String modPassword = stdin.readLineSync() as String;
      stdin.echoMode = true;
      print('');
      Map user_role = {
        'name': user1.username,
        'role': "admin",
      };
      List<Map> role_list = [user_role];
      Map<String, dynamic> s_map = {
        'channellist': [],
        'mememberlist': role_list,
        'modPassword': Admin.hashPwd(modPassword),
      };

      await server_store.record(servername).put(db2, s_map);
      print("Server created successfully");
    }
  }

  Future? joinSerever(Database db2, StoreRef<String, Map> server_store,
      User user1, var server_record) async {
    if (await super.logged_in(user1)) {
      return;
    } else {
      stdout.write("Name of the server: ");
      final servername = stdin.readLineSync() as String;
      this.name = servername;

      if (await super.no_any_server_exist(servername, db2, server_store)) {
        return;
      }
      Map<String, dynamic> roleList = await server_store
          .record(servername)
          .get(db2) as Map<String, dynamic>;
      List b = roleList['mememberlist'];
      for (var use in b) {
        if (use['name'] == user1.username) {
          print("user is already in the given server");
          return;
        }
      }
      stdout.write("Role [mod/newbie]: ");
      final role_type = stdin.readLineSync() as String;
      var user_role;
      switch (role_type) {
        case 'mod':
          stdout.write("Enter password for mod access: ");
          String s_pass = stdin.readLineSync() as String;
          if (Admin.comparePwd(s_pass, roleList['modPassword'])) {
            user_role = ServerType.mod;
            break;
          } else {
            print("Invalid password ");
            return;
          }

        case 'newbie':
          user_role = ServerType.newbie;

          break;
        default:
          print("Please enter a valid role");
          return;
      }
      Map cat = {
        'name': user1.username,
        'role': role_type,
      };
      roleList = cloneMap(roleList);
      roleList['mememberlist'].add(cat);
      // await server_store.record(servername).delete(db2);
      await server_store.record(servername).put(db2, roleList);
      print("User successfully added to the server");
    }
  }
}
