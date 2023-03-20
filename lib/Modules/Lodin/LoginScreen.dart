import 'package:chata_pp/Modules/Lodin/LoginNavigetor.dart';
import 'package:chata_pp/Modules/Lodin/resetPassword.dart';
import 'package:chata_pp/Modules/Register/Register_Screen.dart';
import 'package:chata_pp/Modules/home_Screen/Home_Screen.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/models/My_User.dart';
import 'package:chata_pp/reuseable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_Provider.dart';
import 'LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  static const String roudeName = '///';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigetor {
  var EmailController = TextEditingController();
  var PassswordController = TextEditingController();
  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  initViewModel() {
    return LoginViewModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  void GoToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.user = user;
    Navigator.pushReplacementNamed(context, HomeScreen.roudeName);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/backgroundScreen.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: width * 0.45,
                          height: height * 0.3,
                          margin: EdgeInsets.only(
                            left: 30,
                          ),
                          child: Image.asset('assets/login1.png')),
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
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: obscureText,
                        controller: PassswordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (obscureText == false) {
                                obscureText = true;
                              } else if (obscureText == true) {
                                obscureText = false;
                              }
                              setState(() {});
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: 'Enter Your Password',
                        ),
                        validator: (text) {
                          if (text!.isEmpty || text.trim().isEmpty) {
                            return 'Pleas Enter Your Password';
                          }
                          if (text.length < 6) {
                            return 'Password Enter Valid ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                          text: 'Login',
                          onPressed: () {
                            LoginScreenFunction();
                          },
                          radius: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.roudeName);
                              },
                              child: Text(
                                'don not have an account? ',
                                style: TextStyle(color: Colors.blue),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ResetPasswordScreen.roudeName);
                              },
                              child: Text(
                                'Forget Password? ',
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void LoginScreenFunction() {
    if (formKey.currentState!.validate()) {
      viewModel.LoginInEmail(
          emailAddress: EmailController.text,
          password: PassswordController.text);
    }
  }
}
