import 'package:chata_pp/models/Massage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ReciverMassage extends StatelessWidget {
  Massage massage;

  ReciverMassage(this.massage);

  @override
  Widget build(BuildContext context) {
    int ts = massage.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    int VAE = massage.content.toString().length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            massage.SenderName,
            style: TextStyle(fontSize: 8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VAE > 50
                      ? Expanded(
                          child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(15))),
                              child: Expanded(
                                child: Text(massage.content,
                                    style: TextStyle(color: Colors.white)),
                              )),
                        )
                      : Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(15))),
                          child: Expanded(
                            child: Text(massage.content,
                                style: TextStyle(color: Colors.white)),
                          )),
                  Text(
                    date.substring(12),
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
