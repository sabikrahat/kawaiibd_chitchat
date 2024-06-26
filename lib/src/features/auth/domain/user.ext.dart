part of 'user.dart';

extension FrBsUserExtension on UserModel {
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
    String? token,
    DateTime? created,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      token: token ?? this.token,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJson() => {
        _Json.uid: uid,
        _Json.name: name,
        _Json.email: email,
        _Json.avatar: avatar,
        _Json.token: token,
        _Json.created: created.toUtc().toIso8601String(),
      }..removeWhere((_, v) => v == null);

  String toRawJson() => json.encode(toJson());

  Widget get imageWidget => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryColor, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: borderRadius45,
              child: avatar == null
                  ? Container(
                      height: 45.0,
                      width: 45.0,
                      color: kPrimaryColor.withOpacity(0.4),
                      child: FittedBox(
                        child: Text(
                          '${name.split(' ').first.split('').first}${name.split(' ').last.split('').first}',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    )
                  : FastCachedImage(
                      height: 45.0,
                      width: 45.0,
                      url: avatar ?? '',
                      loadingBuilder: (_, p) => Container(
                        height: 45.0,
                        width: 45.0,
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: borderRadius45,
                          child: const SpinKitThreeBounce(
                            color: kPrimaryColor,
                            size: 15.0,
                          ),
                        ),
                      ),
                      errorBuilder: (_, __, ___) => const SizedBox(
                        height: 45.0,
                        width: 45.0,
                        child: Icon(Icons.error),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      );

  Widget imageWidgetWithSize([double s = 45]) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: kPrimaryColor, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: borderRadius45,
              child: avatar == null
                  ? Container(
                      height: s,
                      width: s,
                      color: kPrimaryColor.withOpacity(0.4),
                      child: FittedBox(
                        child: Text(
                          '${name.split(' ').first.split('').first}${name.split(' ').last.split('').first}',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    )
                  : FastCachedImage(
                      height: s,
                      width: s,
                      url: avatar ?? '',
                      loadingBuilder: (_, p) => Container(
                        height: s,
                        width: s,
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: borderRadius45,
                          child: const SpinKitThreeBounce(
                            color: kPrimaryColor,
                            size: 15.0,
                          ),
                        ),
                      ),
                      errorBuilder: (_, __, ___) => SizedBox(
                        height: s,
                        width: s,
                        child: const Icon(Icons.error),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      );
}
