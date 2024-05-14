import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/user.dart';
import '../domain/chat.room.dart';

final usersStreamProvider =
    StreamProvider.family((_, String? email) => UserModel.docRef(email));

final singleUserStreamProvider = StreamProvider.family(
    (_, String uid) => UserModel.singleDocRef(uid).snapshots());

final recentUsersStreamProvider = StreamProvider((ref) => ChatRoom.queryRef);
