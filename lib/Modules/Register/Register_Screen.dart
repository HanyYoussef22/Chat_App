import 'package:chata_pp/Modules/Lodin/LoginScreen.dart';
import 'package:chata_pp/Modules/Register/Register_View_Model.dart';
import 'package:chata_pp/Modules/Register/RegisterNavigetor.dart';
import 'package:chata_pp/Modules/home_Screen/Home_Screen.dart';
import 'package:chata_pp/models/My_User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_Provider.dart';
import '../../base.dart';
import '../../reuseable.dart';

class RegisterScreen extends StatefulWidget {
  static const String roudeName = '/';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RgisterViewModel>
    implements RegisterNavigetor {
  bool obscureText = true;
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var UserNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  RgisterViewModel initViewModel() {
    return RgisterViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.user = user;
    Navigator.pushReplacementNamed(context, HomeScreen.roudeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/backgroundScreen.png', fit: BoxFit.fill),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Create Account'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: Formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Enter Your First Name'),
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'Pleas Enter Your First Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Enter Your Last Name'),
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'Pleas Enter Your First Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: UserNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Enter Your User Name'),
                      validator: (text) {
                        if (text!.isEmpty || text.trim().isEmpty) {
                          return 'Pleas Enter Your User Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Enter Your Email',
                        // hintStyle: TextStyle(fontSize: 13),
                      ),
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
                      height: 12,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
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
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Password',
                        // hintStyle: TextStyle(fontSize: 13),
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
                      height: 12,
                    ),
                    defaultButton(
                        text: "Create Email",
                        onPressed: () {
                          RegisterScreenFunction();
                        },
                        radius: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.roudeName);
                            },
                            child: Text(
                              'already have an account?',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void RegisterScreenFunction() async {
    if (Formkey.currentState!.validate()) {
      viewModel.createAcount(
          fName: firstNameController.text,
          lName: lastNameController.text,
          userName: UserNameController.text,
          email: emailController.text,
          password: passwordController.text);
    }
  }
}
