import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_contact_tracking/models/user.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'dart:math';

Random random = Random();
final FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference userCollection = firestore.collection('users');

class UserDatabaseService {
  late User user;

  Future<String> generateRandomHexUcid() async {
    int length = 32;
    String chars = '0123456789ABCDEF';
    String hex = '';
    while (length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    if (await isUcidExists(hex)) {
      return generateRandomHexUcid();
    }
    return hex;
  }

  Future<bool> isUcidExists(String ucid) async => await userCollection
      .where("ucid", isEqualTo: ucid.toUpperCase())
      .get()
      .then((value) => value.size > 0 ? true : false);

  Future<String> getUidFromUcid(String ucid) async {
    return await userCollection
        .where('ucid', isEqualTo: ucid.toUpperCase())
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs[0].id;
    });
  }

  void createUserData(User user) async {
    try {
      // print(user.uid);
      // print(user.email.runtimeType);
      // print('asd');
      generateRandomHexUcid().then((value) async {
        return await userCollection.doc(user.uid).set({
          'ucid': value,
          'email': user.email.toString(),
          'phone': user.phone,
          'name': user.name,
          'surname': user.surname,
          'citizenshipID': user.citizenshipID,
          'birthDate': user.birthDate,
          'sex': user.sex,
          'healthStatus': HealthStatus.unknown.toShortString(),
          'signUpDate': Timestamp.now(),
        });
      });
    } catch (e) {
      print('createUserData :::::: $e');
    }
  }

  Future<void> updateUserData(
      {String? email,
      String? name,
      String? surname,
      String? citizenshipID,
      Timestamp? birthDate,
      HealthStatus? healthStatus,
      Sex? sex}) async {
    if (email != null) {
      await userCollection.doc(user.uid).update({'email': email});
    }
    if (name != null && name.isNotEmpty) {
      await userCollection.doc(user.uid).update({'name': name});
    }
    if (surname != null && surname.isNotEmpty) {
      await userCollection.doc(user.uid).update({'surname': surname});
    }
    if (citizenshipID != null && citizenshipID.isNotEmpty) {
      await userCollection
          .doc(user.uid)
          .update({'citizenshipID': citizenshipID});
    }
    if (birthDate != null) {
      await userCollection.doc(user.uid).update({'birthDate': birthDate});
    }
    if (sex != null) {
      await userCollection.doc(user.uid).update({'sex': sex.toShortString()});
    }
  }

  Future<void> updateUsersHealthStatus(HealthStatus healthStatus) async {
    return await userCollection
        .doc(user.uid)
        .update({'healthStatus': healthStatus.toShortString()});
  }

  Future<void> updateUsersPhoneData(String? phone) async {
    return await userCollection.doc(user.uid).update({'phone': phone});
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      user.setUcid = data['ucid'];
      user.setPhone = data['phone'];
      user.setName = data['name'];
      user.setSurname = data['surname'];
      user.setCitizenshipID = data['citizenshipID'];
      user.setBirthDate = data['birthDate'];
      user.setSex = data['sex'] != null
          ? EnumToString.fromString(Sex.values, data['sex'])
          : null;
      user.setHealthStatus =
          EnumToString.fromString(HealthStatus.values, data['healthStatus'])
              as HealthStatus;

      return user;
    } catch (e) {
      print('userDataFromSnapshot ::::: $e');
    }
    return user;
  }

  Stream<User> get userData {
    return userCollection.doc(user.uid).snapshots().map(_userDataFromSnapshot);
  }
}
