import 'package:chata_pp/Modules/Lodin/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../reuseable.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String roudeName = 'pass';
  var EmailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Reset Password ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(
                height: 5.9,
              ),
              Text(
                'Enter the email address and we\'ll send email to reset your password ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Center(child: Image.asset('assets/pass.png')),
              TextFormField(
                controller: EmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter Your Email'),
                validator: (text) {
                  if (text!.isEmpty || text.trim().isEmpty) {
                    return 'Pleas Enter Your Email';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return 'Email not Valid';
                  }
                  return null;
                },
              ),
              Expanded(flex: 1, child: Container()),
              defaultButton(
                  text: 'Reset Password',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: EmailController.text);
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              width: 700,
                              buttonsBorderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              title: 'Sent Successfully',
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              descTextStyle: TextStyle(fontSize: 15),
                              desc:
                                  'Password reset email has been sent, please check your email.',
                              showCloseIcon: true,
                              // btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                              btnOkText: 'OK')
                          .show();
                    }
                  },
                  radius: 12),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void RestPass() {
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: EmailController.text);
    }
  }
}
