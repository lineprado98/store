import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static DateTime fromTimestamp(Timestamp timeStamp) {
    return DateTime.fromMicrosecondsSinceEpoch(
      timeStamp.seconds * 1000000 + timeStamp.nanoseconds ~/ 1000,
      isUtc: true, // ou false, dependendo do seu caso
    );
  }
}
