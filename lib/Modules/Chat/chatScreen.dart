import 'package:chata_pp/Modules/Chat/ChatNavgetor.dart';
import 'package:chata_pp/Modules/Chat/Chat_ViewModel.dart';
import 'package:chata_pp/Provider/user_Provider.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/models/Massage.dart';
import 'package:chata_pp/models/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datdbase/database_utils.dart';
import 'MassageDetalis.dart';

class ChatScreen extends StatefulWidget {
  static const String roudName = 'Chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements ChatNavgetor {
  var massageContentController = TextEditingController();

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var provider = Provider.of<UserProvider>(context);
    var room = ModalRoute.of(context)?.settings.arguments as Rooms;
    viewModel.user = provider.user!;
    viewModel.rooms = room;

    return ChangeNotifierProvider(
      create: (c) => viewModel,
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
            title: Text('${room.titel}'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              margin:
                  EdgeInsets.only(top: height * 0.05, bottom: height * 0.01),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: StreamBuilder<QuerySnapshot<Massage>>(
                      stream: DataBaseUtil.getMassageFromFirStoreStrem(room.Id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text('something went wrong');
                        }

                        List massage =
                            snapshot.data!.docs.map((e) => e.data()).toList();
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                              itemCount: massage.length,
                              itemBuilder: (context, index) {
                                return MassageDatails(massage[index]);
                              }),
                        );
                      },
                    ),
                  ),
                  Container(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.white70,
                              hintText: 'Type Massage',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5)))),
                          controller: massageContentController,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          InsertMassage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.blue,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  void InsertMassage() {
    viewModel.AddMassegeInChat(massageContentController.text);
  }

  @override
  void ClearForm() {
    massageContentController.clear();
  }
}
