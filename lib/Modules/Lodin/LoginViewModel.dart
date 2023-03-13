import 'package:chata_pp/Modules/Lodin/LoginNavigetor.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/datdbase/database_utils.dart';
import 'package:chata_pp/models/My_User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigetor> {
  String? massege;

  void LoginInEmail(
      {required String emailAddress, required String password}) async {
    try {
      navigetor.showLoading(IsDissmassable: false);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      navigetor.hidMassage();
      var user = await DataBaseUtil.readUser(credential.user?.uid ?? "");
      navigetor.GoToHome(user);
      // massege='Login Successfully';
      // massege='Login Successfully';
      if (user == null) {
        massege = 'Failed Complete Sing in Pleas Try again later';
      } else {
        navigetor.hidMassage();
        navigetor.GoToHome(user);
      }
      // navigetor.hidMassage();
    } on FirebaseAuthException catch (e) {
      navigetor.hidMassage();
      if (e.code == 'user-not-found') {
        massege = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        massege = 'Wrong password provided for that user.';

        print('Wrong password provided for that user.');
      }
      navigetor.showMassage(massege!);
    }
  }
}
