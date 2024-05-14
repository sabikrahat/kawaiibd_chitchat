part of 'message.dart';

extension FrBsUserFrBsExtension on MessageModel {
  //
  String get chatRoomId => createChatRoomId(senderId, receiverId);

  bool get isMeSender => senderId == FirebaseAuth.instance.currentUser?.uid;

  //
  Future<void> saveFrBs() async {
    if (id == null) {
      await ChatRoom(
              lastMessage: message,
              lastSenderId: senderId,
              users: [senderId, receiverId],
              lastMessageTime: created)
          .saveFrBs();
      final doc = await MessageModel.ref(receiverId).add(this);
      id = doc.id;
    } else {
      await MessageModel.ref(receiverId).doc(id).set(this);
    }
  }
}
