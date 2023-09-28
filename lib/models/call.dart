import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final logger = Logger();

enum XCallType { audio, video }

class Call {
  final String from;
  final String to;
  final String channelName;
  final String token;
  final List<String> ids;
  final XCallType type;
  final bool missed;
  final DateTime createdAt;
  final DateTime updatedAt;

  Call({
    required this.from,
    required this.to,
    required this.channelName,
    required this.token,
    required this.ids,
    required this.type,
    required this.missed,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Call object into a map
  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
      'channelName': channelName,
      'token': token,
      'ids': ids,
      'type': type.toString().split('.').last, // convert enum to string
      'missed': missed,
      'createdAt':
          Timestamp.fromDate(createdAt), // convert DateTime to Timestamp
      'updatedAt':
          Timestamp.fromDate(updatedAt), // convert DateTime to Timestamp
    };
  }
}
