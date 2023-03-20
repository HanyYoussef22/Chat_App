import 'package:chata_pp/models/Massage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class SenderMassage extends StatelessWidget {
  Massage massage;

  SenderMassage(this.massage);

  @override
  Widget build(BuildContext context) {
    int ts = massage.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    int VAE = massage.content.toString().length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            massage.SenderName,
            style: TextStyle(fontSize: 8),
          ),
          Row(
            // mainAxisSize:MainAxisSize.values.length(50),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VAE > 50
                  ? Expanded(
                      child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(0))),
                          child: Text(massage.content,
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    )
                  : Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(0))),
                      child: Text(massage.content,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white)))
            ],
          ),
          Text(
            date.substring(12),
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
