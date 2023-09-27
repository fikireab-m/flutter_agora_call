import 'dart:convert';

enum XCallType {
  voice,
  video;

  static XCallType fromString(String str) {
    return str == 'Url' ? voice : video;
  }
}

class XCall {
  final String id;
  final String from;
  final String to;
  final String chatId;
  final List<String> ids;
  final XCallType type;
  final String relationId;
  final bool answered;

  const XCall({
    required this.id,
    required this.from,
    required this.to,
    required this.chatId,
    required this.relationId,
    required this.type,
    required this.ids,
    required this.answered,
  });

  factory XCall.fromJson(json) {
    return XCall(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      chatId: json['chatId'],
      ids: List<String>.from(json['ids']),
      answered: json["answered"] ?? false,
      relationId: json['relationId'],
      type: XCallType.fromString(json['type']),
    );
  }

  Map<String, dynamic> toJson([bool toStr = false]) {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'ids': ids,
      'chatId': chatId,
      'answered': answered,
      'relationId': relationId,
      'type': type.name,
    };
  }

  @override
  String toString() => jsonEncode(toJson(true));

  List<Object?> get props => [id];
}
