import 'package:chata_pp/models/My_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../datdbase/database_utils.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  MyUser? user;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (firebaseUser != null) {
      user = await DataBaseUtil.readUser(firebaseUser?.uid ?? "");
    }
  }
}
