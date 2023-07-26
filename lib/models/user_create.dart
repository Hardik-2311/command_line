import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:crypt/crypt.dart';

import 'package:discord/exceptions/exceptions.dart';

//create a user
class User {
  String username;
  String password;
  //constructor

  User(this.username, this.password);

  //function for
  //username is nil

  printUser(User user1) {
    if (user1.username == "0") {
      print("there is no user at this moment");
      return;
    } else {
      print(username);
    }
  }
}

class Admin extends Exception {
  late String username;
  late String password;
  Admin(this.username, this.password);
  Admin.fun();

  //hash the password using crypt

  static String hashPwd(String pass) {
    return Crypt.sha256(pass, rounds: 1000).toString();
  }

  static bool comparePwd(String passValue, String hashed) {
    final hashedPwd = Crypt(hashed);
    return hashedPwd.match(passValue);
  }

  //function to create the user

  Future<void> register(
      Database db1, StoreRef<String, String> userStore, User user1) async {
    if (user1.username != "0") {
      print("already login logout please!");
    }

    stdout.write("Username -> ");
    final username = stdin.readLineSync() as String;
    var record = await userStore.find(db1);
    for (var rec in record) {
      if (rec.key == username) {
        print("Username already exists. Please choose a different username");
        return;
      }
    }
    stdout.write("Password -> ");
    var pass = stdin.readLineSync() as String;
    print('');
    stdout.write("Confirm Password :");
    var confirm=stdin.readLineSync() as String;
    print('');

    if(pass!=confirm){
      print("try again password doesnt matched!!");
    }
    else{
      pass=hashPwd(pass);
    }



    //objects of the class

    Admin newUser=Admin(username, pass);

    await userStore.record(newUser.username).put(db1, newUser.password);

    user1.username=username;
    user1.password=pass;

    print("user registered successfully");
  }
}
