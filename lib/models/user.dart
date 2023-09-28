import 'dart:convert';

class XUser {
  String id;
  String? userName;
  XUser({
    required this.id,
    this.userName,
  });

  factory XUser.fromMap(map) {
    return XUser(
      id: map["id"] ?? "",
      userName: map["userName"],
    );
  }

  Map<String, dynamic> toMap({toString = false}) => {
        "id": id,
        "userName": userName,
      };
  @override
  String toString() => jsonEncode(toMap(toString: true));
}
