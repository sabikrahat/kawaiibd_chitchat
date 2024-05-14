part of 'chat.room.dart';

extension ChatRoomFrBsExt on ChatRoom {

  String get opponentId => users.firstWhere((e) => e != FirebaseAuth.instance.currentUser?.uid);

  String get chatRoomId => createChatRoomId(users[0], users[1]);

  bool get isMeSender => lastSenderId == FirebaseAuth.instance.currentUser?.uid;

  Future<void> saveFrBs() async => await ChatRoom.ref.doc(chatRoomId).set(this);
}
