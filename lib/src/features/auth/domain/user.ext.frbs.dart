part of 'user.dart';

extension FrBsUserFrBsExtension on UserModel {
  //
  Future<void> saveFrBs() async =>
      await UserModel.collectionRef.doc(uid).set(this);
}

extension FrBsListUserFrBsExtension on List<UserModel> {
  //
  List<UserModel> get sortByName {
    sort((a, b) => a.name.compareTo(b.name));
    return this;
  }

  List<UserModel> get sortByCreated {
    sort((a, b) => a.created.compareTo(b.created));
    return this;
  }

  List<UserModel> get removeOwn {
    final id = FirebaseAuth.instance.currentUser?.uid;
    if (id == null) return this;
    removeWhere((e) => e.uid == id);
    return this;
  }
}
