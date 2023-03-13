import 'package:chata_pp/Modules/add_Rooms/add_rome_navigetor.dart';
import 'package:chata_pp/base.dart';
import 'package:chata_pp/datdbase/database_utils.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigetor> {
  String? massege;

  AddRome(
      {required String titel, required String catId, required String desc}) {
    navigetor.showLoading(IsDissmassable: true);
    try {
      DataBaseUtil.creatRoom(titel, catId, desc);
      navigetor.addSuccesRoom();
    } catch (e) {
      massege = e.toString();
      massege = 'worng';
    }
    navigetor.hidMassage();
    if (massege != null) {
      navigetor.showMassage(massege!);
    } else {
      navigetor.addSuccesRoom();
    }
  }
}
