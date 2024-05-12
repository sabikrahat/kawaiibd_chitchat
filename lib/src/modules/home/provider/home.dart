import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/model/user.dart';

final usersStreamProvider =
    StreamProvider.family((_, String? email) => UserModel.docRef(email));
