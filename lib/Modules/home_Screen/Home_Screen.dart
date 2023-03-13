import 'package:chata_pp/Modules/add_Rooms/add_room.dart';
import 'package:chata_pp/Modules/home_Screen/Home_Navigetor.dart';
import 'package:chata_pp/Modules/home_Screen/Home_View_Model.dart';
import 'package:chata_pp/Provider/user_Provider.dart';
import 'package:chata_pp/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datdbase/database_utils.dart';

class HomeScreen extends StatefulWidget {
  static const String roudeName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigetor {
  var provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  HomeViewModel initViewModel() {
    // TODO: implement initViewModel
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    provider.initMyUser();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Chat'),
            automaticallyImplyLeading: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomScreen.roudeName);
            },
            child: Icon(Icons.add),
          ),
          body: Column(
            children: [Text(provider.user?.fName ?? "Faild")],
          ),
        )
      ],
    );
  }
}
