import 'package:firebase_auth/firebase_auth.dart';

String createChatRoomId(String s, [String? r]) {
  r ??= FirebaseAuth.instance.currentUser?.uid ?? '';
  if (s.compareTo(r) < 0){
    return "${r}_ChitChat_$s";
  } else {
    return "${s}_ChitChat_$r";
  }
}
