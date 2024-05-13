part of 'chat.room.dart';

extension ChatRoomExt on ChatRoom {
  ChatRoom copyWith({
    String? id,
    String? lastMessage,
    String? lastSenderId,
    List<String>? users,
    DateTime? lastMessageTime,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      users: users ?? this.users,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.lastMessage: lastMessage,
      _Json.lastSenderId: lastSenderId,
      _Json.users: users,
      _Json.lastMessageTime: lastMessageTime.toUtc().toIso8601String(),
    }..removeWhere((_, v) => v == null);
  }

  String toRawJson() => json.encode(toJson());
}
