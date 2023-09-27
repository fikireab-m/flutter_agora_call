import 'dart:convert';

class XUser {
  String id;
  String? name;
  XUser({
    required this.id,
    this.name,
  });

  factory XUser.fromMap(map) {
    return XUser(
      id: map["id"] ?? "",
      name: map["userName"],
    );
  }

  Map<String, dynamic> toMap({toString = false}) => {
        "id": id,
        "userName": name,
      };
  @override
  String toString() => jsonEncode(toMap(toString: true));
}
