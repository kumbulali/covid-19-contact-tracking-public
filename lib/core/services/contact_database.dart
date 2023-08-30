import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_contact_tracking/models/contact.dart';

class ContactDatabaseService {
  List<String> contactedUCIDsToday = [];
  final CollectionReference contactsCollection =
      FirebaseFirestore.instance.collection('contacts');
  final DateTime now = DateTime.now();
  Future<void> createContact(Contact contact) async {
    return await contactsCollection.doc().set({
      'contactUCIDs': contact.contactUCIDs,
      'contactUIDs': contact.contactUIDs,
      'contactLat': contact.contactLat,
      'contactLong': contact.contactLong,
      'contactDate': Timestamp.fromDate(DateTime.now())
    });
  }

  Future<bool> isContactedToday(List<String> ucids) async {
    return await contactsCollection
        .where('contactDate',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(now.year, now.month, now.day)))
        .where('contactUCIDs', arrayContains: ucids[0].toUpperCase())
        .get()
        .then((querySnapshot) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        if (List.castFrom(querySnapshot.docs[0].get('contactUCIDs'))
            .contains(ucids[1].toUpperCase())) {
          return true;
        }
      }
      return false;
    });
  }

  Future<int> getContactCountByDate(DateTime date, String uid) {
    return contactsCollection
        .where('contactDate', isGreaterThanOrEqualTo: Timestamp.fromDate(date))
        .where('contactDate',
            isLessThan: Timestamp.fromDate(date.add(const Duration(days: 1))))
        .where('contactUIDs', arrayContains: uid)
        .get()
        .then((value) => value.docs.length);
  }

  List<Contact> _contactsDataFromSnapshot(QuerySnapshot snapshot) {
    List<Contact> tempContacts = <Contact>[];
    for (var doc in snapshot.docs) {
      tempContacts.add(Contact(
          contactID: doc.id,
          contactUCIDs: List.castFrom(doc.get('contactUCIDs')),
          contactUIDs: List.castFrom(doc.get('contactUIDs')),
          contactLat: doc.get('contactLat'),
          contactLong: doc.get('contactLong'),
          contactDate: doc.get('contactDate')));
    }
    return tempContacts;
  }

  Stream<List<Contact>?> getContactData(String uid) {
    return contactsCollection
        .where('contactDate',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(now.year, now.month, now.day)))
        .where('contactUIDs', arrayContains: uid)
        .snapshots()
        .map(_contactsDataFromSnapshot);
  }
}
