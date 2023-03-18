import 'package:chata_pp/Provider/user_Provider.dart';
import 'package:chata_pp/models/Massage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MassageDatails extends StatefulWidget {
  Massage massage;

  MassageDatails(this.massage);

  @override
  State<MassageDatails> createState() => _MassageDatailsState();
}

class _MassageDatailsState extends State<MassageDatails> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    var uu = provider.user?.id == widget.massage.senderId;
    return provider.user?.id == widget.massage.senderId
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.massage.SenderName,
                  style: TextStyle(fontSize: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text(widget.massage.content),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.massage.SenderName,
                  style: TextStyle(fontSize: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        widget.massage.content,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
