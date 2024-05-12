import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kawaiibd_flutterfire_task/src/modules/auth/model/user.dart';

final usersStreamProvider =
    StreamProvider((_) => UserModel.collectionRef.snapshots());
