//serevr exists
//channel exists
//already login
//already registered
//category exists
import 'package:sembast/sembast.dart';
import 'package:discord/models/user_create.dart';

class Exception {
  //for checking user is registered or not

  Future<bool> registered(String receiver, Database db1,
      StoreRef<String, String> userStore, User user1)async {
     //if bool is true user is registered
     var record = await userStore.find(db1);//to find in the database
     bool output=false;

     for(var i in record){
      if(i.key==receiver){
        output=true;
      }
     }
     if(output){
      return true;
     }
     else{
      return false;
     }

  }
}
