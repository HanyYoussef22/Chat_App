import 'package:chata_pp/Modules/Chat/chatScreen.dart';
import 'package:flutter/material.dart';
import '../../models/Room.dart';

class RoomDetails extends StatelessWidget {
  Rooms room;

  RoomDetails(this.room);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.roudName, arguments: room);
      },
      child: Card(
        elevation: 50,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xfff7f7f7),
          ),
          child: Center(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/${room.catId}.jpeg',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        // height: height*.03,
                        width: width * 1,
                        child: Center(
                            child: Text(
                          '${room.desc}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
