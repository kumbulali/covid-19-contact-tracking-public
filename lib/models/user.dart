import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

class User {
  final String uid;
  final String? email;
  String? ucid;
  String? name;
  String? surname;
  String? citizenshipID;
  String? phone;
  Timestamp? birthDate;
  HealthStatus? healthStatus;
  Sex? sex;
  final Timestamp? signUpDate;
  List<int> lastContactNumbers = [0, 0, 0, 0, 0];

  set setUcid(String? _ucid) {
    ucid = _ucid;
  }

  set setName(String? _name) {
    name = _name;
  }

  set setSurname(String? _surname) {
    surname = _surname;
  }

  set setCitizenshipID(String? _citizenshipID) {
    citizenshipID = _citizenshipID;
  }

  set setPhone(String? _phone) {
    phone = _phone;
  }

  set setBirthDate(Timestamp? _birthDate) {
    birthDate = _birthDate;
  }

  set setSex(Sex? _sex) {
    sex = _sex;
  }

  set setHealthStatus(HealthStatus? _healthStatus) {
    healthStatus = _healthStatus;
  }

  User(
      {required this.uid,
      this.ucid,
      this.email,
      this.name,
      this.phone,
      this.surname,
      this.citizenshipID,
      this.birthDate,
      this.healthStatus,
      this.sex,
      this.signUpDate});

  int calculateAge() {
    DateTime birthDate = this.birthDate!.toDate();
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}

enum HealthStatus { riskless, contacted, infected, unknown }

enum Sex { male, female }

extension ParseToString on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
