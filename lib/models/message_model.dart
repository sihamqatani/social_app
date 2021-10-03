class MessageModel {
  late String senderId;
  String? reciveId;
  late String dateTime;
  late String text;
  MessageModel({
    required this.senderId,
    this.reciveId,
    required this.dateTime,
    required this.text,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reciveId = json['reciveId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciveId': reciveId,
      'dateTime': dateTime,
      'text': text
    };
  }
}
