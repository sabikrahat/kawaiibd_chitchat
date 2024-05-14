part of 'message.dart';

extension MessageModelX on MessageModel {
  MessageModel copyWith({
    String? id,
    String? message,
    String? senderId,
    String? receiverId,
    DateTime? created,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _Json.id: id,
      _Json.message: message,
      _Json.senderId: senderId,
      _Json.receiverId: receiverId,
      _Json.created: created.toUtc().toIso8601String(),
    }..removeWhere((_, v) => v == null);
  }

  String toRawJson() => json.encode(toJson());
}
