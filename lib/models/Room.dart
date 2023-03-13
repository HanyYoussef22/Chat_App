class Rooms {
  static const String CollecationName = 'Rooms';

  String Id;
  String titel;
  String desc;
  String catId;

  Rooms(
      {required this.Id,
      required this.titel,
      required this.desc,
      required this.catId});

  Rooms.fromJson(Map<String, dynamic> json)
      : this(
          Id: json['Id'] as String,
          titel: json['titel'] as String,
          desc: json['desc'] as String,
          catId: json['catId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'titel': titel,
      'desc': desc,
      'catId': catId,
    };
  }
}
