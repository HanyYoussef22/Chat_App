import 'package:chata_pp/models/Massage.dart';
import 'package:chata_pp/models/My_User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Room.dart';

class DataBaseUtil {
  static CollectionReference<MyUser> getUserCollectin() {
    return FirebaseFirestore.instance
        .collection(MyUser.CollecationName)
        .withConverter(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<Rooms> getRoomsCollectin() {
    return FirebaseFirestore.instance
        .collection(Rooms.CollecationName)
        .withConverter<Rooms>(
            fromFirestore: (snapshot, _) => Rooms.fromJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson());
  }

  //This CollectionReference into CollectionRoom
  static CollectionReference<Massage> getMassageCollectin(String roomId) {
    return getRoomsCollectin()
        .doc(roomId)
        .collection(Massage.CollectionMassage)
        .withConverter<Massage>(
            fromFirestore: (snapshot, _) => Massage.fromJson(snapshot.data()!),
            toFirestore: (massage, _) => massage.toJson());
  }

  static Future<void> insertMassageToFirstore(Massage massage) async {
    var roomMassage = getMassageCollectin(massage.roomId);
    var docRef = roomMassage.doc();
    massage.id = docRef.id;
    return docRef.set(massage);
  }

  static Stream<QuerySnapshot<Massage>> getMassageFromFirStoreStrem(
      String roomId) {
    return getMassageCollectin(roomId).snapshots();
  }

  static Future<void> creatRoom(String titel, String catId, String desc) {
    var docRef = getRoomsCollectin().doc();
    Rooms room = Rooms(Id: docRef.id, titel: titel, desc: desc, catId: catId);
    return docRef.set(room);
  }

  // git Data rooms From Firebase
  static Future<List<Rooms>> getRoomsFromFirStore() async {
    var QuerySnapshot = await getRoomsCollectin().get();
    return QuerySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // git Data rooms From Firebase Stream
  static Stream<QuerySnapshot<Rooms>> getRoomsFromFirStoreStream() {
    return getRoomsCollectin().snapshots();
  }

//creat data base For User By Id user For Register Screen
  static Future<void> creatDBforUser(MyUser user) {
    return getUserCollectin().doc(user.id).set(user);
  }

  static Future<MyUser> readUser(String uId) async {
    //Response Data For User By login ,take uId
    var userSnapshot = await getUserCollectin().doc(uId).get();
    return userSnapshot.data()!;
  }

// static Future<MyUser> readUrser(String userId)async{
//   var userSnapShot=await getUserCollectin().doc(userId).get();
//   return userSnapShot.data()!;
// }
}
