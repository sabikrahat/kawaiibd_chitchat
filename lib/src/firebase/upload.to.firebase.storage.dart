import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../config/get.platform.dart';
import '../utils/extensions/extensions.dart';
import '../utils/logger/logger_helper.dart';

Future<String?> uploadImageToFirebae(dynamic file) async {
  if (file == null) return null;
  try {
    final ref = FirebaseStorage.instance.ref().child(
          'images/${DateTime.now().millisecondsSinceEpoch}.${file.path?.split('.').last ?? 'jpg'}',
        );
    UploadTask? uploadTask =
        ref.putFile(pt.isMobile ? file : (file as PlatformFile).toFile);

    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();

    log.f('Photo uploaded. Url: $downloadUrl');

    return downloadUrl;
  } catch (e) {
    EasyLoading.showError(e.toString());
    log.e('Error in uploading image for : ${e.toString()}');
    return null;
  }
}
