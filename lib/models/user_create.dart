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
      return;
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
    stdin.echoMode = false;
    var pass = stdin.readLineSync() as String;
    print('');
    stdin.echoMode = true;
    stdout.write("Confirm Password :");
    stdin.echoMode = false;
    var confirm = stdin.readLineSync() as String;
    stdin.echoMode = true;
    print('');

    if (pass != confirm) {
      print("try again password doesnt matched!!");
      return;
    } else {
      pass = hashPwd(pass);
    }

    //objects of the class

    Admin newUser = Admin(username, pass);

    await userStore.record(newUser.username).put(db1, newUser.password);

    user1.username = username;
    user1.password = pass;

    print("user registered successfully");
  }

  //login function
  Future<void> login(
      Database db1, StoreRef<String, String> userStore, User user1) async {
    stdout.write("Username: ");
    final username = stdin.readLineSync();
    if (username == null) {
      return;
    }

    if (!(await super.registered(username, db1, userStore, user1))) {
      print("user not registered resgister first");
      return;
    }

    var databasePass = await userStore.record(username).get(db1);

    if (databasePass == 'null') {
      return;
    }
    stdout.write("Password :");
    stdin.echoMode = false;
    final pass = stdin.readLineSync();
    stdin.echoMode = true;
    print('');
    if (pass == null) {
      return;
    } else if (comparePwd(pass, databasePass!)) {
      user1.username = username;
      user1.password = pass;

      print("logged in");
    } else {
      print("password doesnt matched");
      return;
    }
  }

  logout(User user1) {
    if (user1.username == "0") {
      return;
    } else {
      user1.username = "0";
      user1.password = "0";
      print("logout successfully");
      return;
    }
  }

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
