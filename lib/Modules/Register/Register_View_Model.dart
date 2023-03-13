import 'package:chata_pp/Modules/Register/RegisterNavigetor.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/datdbase/database_utils.dart';
import 'package:chata_pp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/My_User.dart';

class RgisterViewModel extends BaseViewModel<RegisterNavigetor> {
  String? massage;

  void createAcount({
    required String fName,
    required String lName,
    required String userName,
    required String email,
    required String password,
  }) async {
    // late RgisterViewModel viewModel;
    try {
      navigetor.showLoading(IsDissmassable: false);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser user = MyUser(
          id: credential.user!.uid,
          fName: fName,
          lName: lName,
          userName: userName,
          email: email);
      var userCreated = DataBaseUtil.creatDBforUser(user);
      var User = await DataBaseUtil.readUser(credential.user?.uid ?? "");
      navigetor.showLoading(IsDissmassable: false);
      navigetor.goToHome(User);
      // navigetor.hidMassage();
    } on FirebaseAuthException catch (e) {
      navigetor.hidMassage();
      if (e.code == 'weak-password') {
        navigetor.showMassage('The password provided is too weak.');
        massage = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        massage = 'The account already exists for that email';
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    navigetor.showMassage(massage!);
  }
}
