part of 'message.dart';

extension FrBsUserFrBsExtension on MessageModel {
  //
  String get chatRoomId => createChatRoomId(senderId, receiverId);

  bool get isMeSender => senderId == FirebaseAuth.instance.currentUser?.uid;

  //
  Future<void> saveFrBs() async {
    if (id == null) {
      final doc = await MessageModel.ref
          .doc(chatRoomId)
          .collection('chats')
          .add(toJson());
      id = doc.id;
    } else {
      await MessageModel.ref.doc(chatRoomId).set(this);
    }
  }
}

String createChatRoomId(String s, [String? r]) {
  r ??= FirebaseAuth.instance.currentUser?.uid ?? '';
  if (s.substring(0, 1).codeUnitAt(0) > r.substring(0, 1).codeUnitAt(0)) {
    return "${r}_ChitChat_$s";
  } else {
    return "${s}_ChitChat_$r";
  }
}
