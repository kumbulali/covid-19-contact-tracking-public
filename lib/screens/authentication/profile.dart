import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:covid19_contact_tracking/utils/border_styles.dart';

class RegisterProfileScreen extends StatefulWidget {
  const RegisterProfileScreen({Key? key}) : super(key: key);
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  String errorMessage = 'Default Error Message';
  bool _errorFlag = false;
  bool _loading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _citizenshipIDController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Sex? sex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      UserDatabaseService userDatabaseService =
          context.read<UserDatabaseService>();
      setState(() {
        if (userDatabaseService.user.sex != null) {
          sex = userDatabaseService.user.sex!;
        }
        if (userDatabaseService.user.birthDate != null) {
          selectedDate = userDatabaseService.user.birthDate!.toDate();
        }
        if (userDatabaseService.user.name != null) {
          _nameController.text = userDatabaseService.user.name!;
        }
        if (userDatabaseService.user.surname != null) {
          _surnameController.text = userDatabaseService.user.surname!;
        }
        if (userDatabaseService.user.citizenshipID != null) {
          _citizenshipIDController.text =
              userDatabaseService.user.citizenshipID!;
        }
      });
    });
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final userDatabaseService = Provider.of<UserDatabaseService>(context);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 77, 206, 215),
            Color.fromARGB(255, 96, 209, 224)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Name",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8, top: 8),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  controller: _nameController,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 142, 222, 229),
                      disabledBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintText: 'Enter your name',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: _nameController.clear,
                          icon: const Icon(Icons.clear))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Surname",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8, top: 8),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  controller: _surnameController,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 142, 222, 229),
                      disabledBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintText: 'Enter your surname',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: _surnameController.clear,
                          icon: const Icon(Icons.clear))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Citizenship ID",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8, top: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  controller: _citizenshipIDController,
                  cursorColor: Colors.cyan,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 142, 222, 229),
                      disabledBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintText: 'Enter your ID number',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: _citizenshipIDController.clear,
                          icon: const Icon(Icons.clear))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Birth Date",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, bottom: 8, top: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.white),
                    elevation: 0,
                    primary: const Color.fromARGB(255, 142, 222, 229),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 64),
                  ),
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: selectedDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          if (newDate != selectedDate) {
                            setState(() {
                              selectedDate = newDate;
                            });
                          }
                        },
                        minimumYear: 1900,
                        maximumDate: DateTime.now(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Sex",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = Sex.male;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              activeColor:
                                  const Color.fromARGB(255, 142, 222, 229),
                              groupValue: sex,
                              value: Sex.male,
                              onChanged: (Sex? value) {
                                setState(() {
                                  sex = value!;
                                });
                              },
                            ),
                            const Text(
                              "Male",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = Sex.female;
                          });
                        },
                        child: Row(
                          children: [
                            Radio(
                              groupValue: sex,
                              activeColor:
                                  const Color.fromARGB(255, 142, 222, 229),
                              value: Sex.female,
                              onChanged: (Sex? value) {
                                setState(() {
                                  sex = value!;
                                });
                              },
                            ),
                            const Text(
                              "Female",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              Visibility(
                  visible: _errorFlag,
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: const Size(double.infinity, 60)),
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() {
                            _loading = true;
                          });
                          await userDatabaseService.updateUserData(
                              name: capitalize(_nameController.text),
                              surname: capitalize(_surnameController.text),
                              citizenshipID: _citizenshipIDController.text,
                              birthDate: Timestamp.fromDate(selectedDate),
                              sex: sex);
                          if (mounted) {
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                  child: _loading
                      ? const SpinKitChasingDots(
                          color: Colors.black,
                          size: 32,
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
