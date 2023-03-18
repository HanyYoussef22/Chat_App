import 'package:chata_pp/Modules/Chat/chatScreen.dart';
import 'package:chata_pp/Modules/Lodin/LoginScreen.dart';
import 'package:chata_pp/Modules/Register/Register_Screen.dart';
import 'package:chata_pp/Modules/add_Rooms/add_room.dart';
import 'package:chata_pp/Modules/home_Screen/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user_Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (c) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    // var FirbaseUser = FirebaseAuth.instance.currentUser!;

    return MaterialApp(
      initialRoute: provider.firebaseUser == null
          ? LoginScreen.roudeName
          : HomeScreen.roudeName,
      routes: {
        ChatScreen.roudName: (context) => ChatScreen(),
        RegisterScreen.roudeName: (context) => RegisterScreen(),
        LoginScreen.roudeName: (context) => LoginScreen(),
        HomeScreen.roudeName: (context) => HomeScreen(),
        AddRoomScreen.roudeName: (context) => AddRoomScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
