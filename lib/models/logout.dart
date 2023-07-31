// ignore_for_file: unused_import

import 'dart:io';
import 'package:discord/models/user_create.dart';

class logout extends User{
  logout(super.username, super.password);

  logOut(User user1) {
    if (user1.username == "0") {
      return;
    } else {
      user1.username = "0";
      user1.password = "0";
      print("logout successfully");
      return;
    }
  }
}