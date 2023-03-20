import 'package:chata_pp/Provider/user_Provider.dart';
import 'package:chata_pp/models/Massage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../datdbase/database_utils.dart';
import 'ReciverMassage.dart';
import 'SenderMassage.dart';

class MassageDatails extends StatelessWidget {
  Massage massage;

  MassageDatails(this.massage);

  @override
  Widget build(BuildContext context) {
    int ts = massage.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    int VAE = massage.content.toString().length;

    var provider = Provider.of<UserProvider>(context);

    var uu = provider.user?.id == massage.senderId;
    return provider.user?.id == massage.senderId
        ? Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.20,
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    DataBaseUtil.DeletMassageFromFireStore(massage);
                  },
                  icon: Icons.delete,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(20),
                  autoClose: true,
                )
              ],
            ),
            child: Container(
              child: provider.user?.id == massage.senderId
                  ? SenderMassage(massage)
                  : ReciverMassage(massage),
            ),
          )
        : Container(
            child: provider.user?.id == massage.senderId
                ? SenderMassage(massage)
                : ReciverMassage(massage),
          );
  }
}

// color: Color(0xffabdbe3),
