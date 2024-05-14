import 'dart:io';

import 'package:flutter/material.dart';

import '../../../local.db/db.functions.dart';
import '../../../local.db/paths.dart';

Future<void> deleteDB() async {
  debugPrint('Deleting Database : ${appDir.db}');
  await HiveFuntions.closeAllBoxes();
  await HiveFuntions.deleteAllBoxes();
  await appDir.root.delete(recursive: true);
  exit(0);
}
