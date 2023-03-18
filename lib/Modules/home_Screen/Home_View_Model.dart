import 'package:chata_pp/base.dart';
import 'package:chata_pp/datdbase/database_utils.dart';
import 'package:chata_pp/models/My_User.dart';
import 'package:chata_pp/models/Room.dart';

import 'Home_Navigetor.dart';

class HomeViewModel extends BaseViewModel<HomeNavigetor> {
  // HomeViewModel(){
  //   getRooms();
  // }
  List<Rooms> rooms = [];

  void getRooms() async {
    rooms = await DataBaseUtil.getRoomsFromFirStore();
  }
}
