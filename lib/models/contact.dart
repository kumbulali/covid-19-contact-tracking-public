import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String? contactID;
  final List<String>? contactUIDs;
  final List<String>? contactUCIDs;
  final double? contactLat;
  final double? contactLong;
  final Timestamp? contactDate;

  Contact(
      {this.contactID,
      this.contactUCIDs,
      this.contactUIDs,
      this.contactDate,
      this.contactLat,
      this.contactLong});

  factory Contact.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Contact(
      contactID: snapshot.id,
      contactUIDs: data?['contactUIDs'],
      contactUCIDs: data?['contactUCIDs'],
      contactLat: data?['contactLat'],
      contactLong: data?['contactLong'],
      contactDate: data?['contactDate'],
    );
  }
}
