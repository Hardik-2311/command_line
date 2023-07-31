import 'dart:io';

import 'package:discord/models/user_create.dart';
import 'package:sembast/sembast.dart';

class Delete extends User {
  Delete(super.username, super.password);
  deleteData(
      Database db1, StoreRef<String, String> userStore, User user1) async {
    stdout.write("Username: ");
    final username = stdin.readLineSync() as String;
    await userStore.record(username).delete(db1);

    if (await username == " ") {
      print(" not a valid usesname ");
      return;
    } else {
      print("user data deleted");
      return;
    }
  }
}
