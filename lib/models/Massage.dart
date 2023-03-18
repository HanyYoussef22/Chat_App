class Massage {
  static String CollectionMassage = 'Massage';
  String id;
  String roomId;
  String content;
  int dateTime;
  String senderId;
  String SenderName;

  Massage(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.SenderName});

  Massage.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomId: json['roomId'],
          content: json['content'],
          dateTime: json['dateTime'],
          senderId: json['senderId'],
          SenderName: json['SenderName'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'dateTime': dateTime,
      'senderId': senderId,
      'SenderName': SenderName,
    };
  }
}
