part of 'user.dart';

extension FrBsUserFrBsExtension on UserModel {
  //
  static CollectionReference<UserModel> get collectionRef =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (s, _) => UserModel.fromJson(s.data()!)..uid = s.id,
            toFirestore: (s, _) => s.toJson(),
          );
  //
  DocumentReference<UserModel> get documentRef => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .withConverter<UserModel>(
        fromFirestore: (s, _) => UserModel.fromJson(s.data()!)..uid = s.id,
        toFirestore: (s, _) => s.toJson(),
      );
  //
  Future<void> saveFrBs() async {
    if (uid == null) {
      final doc = await collectionRef.add(this);
      uid = doc.id;
    } else {
      await collectionRef.doc(uid).set(this);
    }
  }
}
