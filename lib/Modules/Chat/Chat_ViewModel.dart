import 'package:chata_pp/base.dart';
import 'package:chata_pp/datdbase/database_utils.dart';
import 'package:chata_pp/models/Massage.dart';
import 'package:chata_pp/models/Room.dart';

import '../../models/My_User.dart';
import 'ChatNavgetor.dart';

class ChatViewModel extends BaseViewModel<ChatNavgetor> {
  late MyUser user;
  late Rooms rooms;

  AddMassegeInChat(String Content) async {
    Massage massage = Massage(
        roomId: rooms.Id,
        content: Content,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderId: user.id,
        SenderName: user.userName);
    await DataBaseUtil.insertMassageToFirstore(massage);
    navigetor.ClearForm();
  }
}
