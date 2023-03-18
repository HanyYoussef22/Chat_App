import 'package:chata_pp/Modules/add_Rooms/add_room.dart';
import 'package:chata_pp/Modules/home_Screen/Home_Navigetor.dart';
import 'package:chata_pp/Modules/home_Screen/Home_View_Model.dart';
import 'package:chata_pp/Provider/user_Provider.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/models/Room.dart';
import 'package:chata_pp/reuseable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datdbase/database_utils.dart';
import '../../models/Catagory.dart';
import 'RoomWediget.dart';

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
    super.initState();
    viewModel.navigetor = this;
    viewModel.getRooms();
  }

  // HomeScreen(){
  //   viewModel.getRooms();
  //
  // }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    provider.initMyUser();
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/backgroundScreen.png',
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // centerTitle: true,
              title: Text(
                ' Chat',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.roudeName);
              },
              child: Icon(Icons.add),
            ),
            body: Column(
              children: [
                Expanded(

                    // child: ListView.builder(itemCount: viewModel.rooms.length,itemBuilder: (c,index){
                    //   return RoomDetails(viewModel.rooms[index]);
                    // }),
                    child: StreamBuilder<QuerySnapshot<Rooms>>(
                  stream: DataBaseUtil.getRoomsFromFirStoreStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('something went wrong');
                    }

                    List rooms =
                        snapshot.data!.docs.map((e) => e.data()).toList();
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: .8,
                        ),
                        itemBuilder: (context, index) {
                          return RoomDetails(rooms[index]);
                        },
                        itemCount: rooms.length,
                      ),
                    );
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
