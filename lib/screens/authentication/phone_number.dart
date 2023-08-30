import 'dart:async';

import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:covid19_contact_tracking/utils/pinput_themes.dart';
import 'package:covid19_contact_tracking/utils/border_styles.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({Key? key}) : super(key: key);
  @override
  _RegisterPhoneScreenState createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer!.cancel();
          showResendSms = true;
        }
      });
    });
  }

  String errorMessage = 'Default Error Message';
  bool showResendSms = false;
  bool showTimer = false;
  bool showVerificationCodeField = false;
  bool _errorFlag = false;
  bool _loading = false;
  String? smsCode;

  String? _verificationId;
  auth.AuthCredential? _phoneAuthCredential;
  // ignore: unused_field
  int? _code;

  final TextEditingController _phoneNumberController = TextEditingController();

  String phoneNumber = "";
  String initialCountry = 'TR';
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  bool _isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    auth.FirebaseAuth firebaseAuth =
        Provider.of<AuthService>(context).firebaseAuth;
    final authService = Provider.of<AuthService>(context);
    final userDatabaseService = Provider.of<UserDatabaseService>(context);

    //------------------------------------------------------------------------------------

    Future<void> _submitPhoneNumber(String? phoneNumber) async {
      void verificationCompleted(auth.AuthCredential phoneAuthCredential) {
        _phoneAuthCredential = phoneAuthCredential;
        // print("phoneAuthCredential: $phoneAuthCredential");
      }

      void verificationFailed(auth.FirebaseAuthException error) {
        setState(() {
          // print(error.code);
          // errorMessage = authService.getMessageFromErrorCode(error.code);
          // print(error.message);
          _errorFlag = true;
          _loading = false;
        });
      }

      void codeSent(String verificationId, int? code) {
        _verificationId = verificationId;
        _code = code;
        startTimer();
        setState(() {
          showTimer = true;
          showVerificationCodeField = true;
          _loading = false;
        });
      }

      void codeAutoRetrievalTimeout(String verificationId) {
        // print("verificationId: $verificationId");
      }

      try {
        await auth.FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber!,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
      } on auth.FirebaseAuthException catch (e) {
        // print(e.code);
        setState(() {
          _loading = false;
          _errorFlag = true;
          errorMessage = authService.getMessageFromErrorCode(e.code);
        });
      }
    }

    void _submitOTP(String smsCode) async {
      try {
        _phoneAuthCredential = auth.PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: smsCode);
        await firebaseAuth.currentUser!
            .linkWithCredential(_phoneAuthCredential!);
        await userDatabaseService.updateUsersPhoneData(phoneNumber);
        timer!.cancel();
      } on FirebaseAuthException catch (e) {
        // print(e.code);
        setState(() {
          _loading = false;
          _errorFlag = true;
          errorMessage = authService.getMessageFromErrorCode(e.code);
        });
      }
    }

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
            'Phone Verification',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phone Number",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        Visibility(
                          visible: showTimer,
                          child: Text(
                            "$seconds seconds left",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InternationalPhoneNumberInput(
                  isEnabled: !showVerificationCodeField,
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber.toString();
                    //print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    setState(() {
                      _isPhoneNumberValid = true;
                    });
                  },
                  formatInput: true,
                  autoValidateMode: AutovalidateMode.always,
                  selectorConfig: const SelectorConfig(
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: 16,
                      selectorType: PhoneInputSelectorType.DIALOG),
                  ignoreBlank: true,
                  selectorTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  initialValue: number,
                  textFieldController: _phoneNumberController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textStyle: const TextStyle(color: Colors.white),
                  inputBorder: const OutlineInputBorder(),
                  inputDecoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 142, 222, 229),
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: "533 XXX XX XX",
                    suffixIcon: IconButton(
                        color: Colors.white,
                        onPressed: _phoneNumberController.clear,
                        icon: const Icon(Icons.clear)),
                  ),
                  onSaved: (PhoneNumber number) {
                    // print('On Saved: $number');
                  },
                ),
              ),
              Visibility(
                visible: showVerificationCodeField,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "SMS Code",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                              Visibility(
                                visible: showResendSms,
                                child: GestureDetector(
                                    onTap: () {
                                      _submitPhoneNumber(phoneNumber);
                                      seconds = 60;
                                      setState(() {
                                        showResendSms = false;
                                      });
                                    },
                                    child: const Text(
                                      "Resend Code",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                          fontSize: 16),
                                    )),
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Pinput(
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsRetrieverApi,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        onCompleted: (value) =>
                            {_submitOTP(value), smsCode = value},
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: _errorFlag,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              Visibility(
                visible: !showVerificationCodeField,
                child: Padding(
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
                        : _isPhoneNumberValid
                            ? () async {
                                setState(() {
                                  _loading = true;
                                });
                                // print("butona basınca : ${phoneNumber}");
                                if (phoneNumber.isNotEmpty) {
                                  await _submitPhoneNumber(phoneNumber);
                                } else {
                                  setState(() {
                                    errorMessage =
                                        "Phone number can not be empty.";
                                    _errorFlag = true;
                                    _loading = false;
                                  });
                                }
                              }
                            : null,
                    child: _loading
                        ? const SpinKitChasingDots(
                            color: Colors.black,
                            size: 32,
                          )
                        : const Text(
                            'Send SMS',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              Visibility(
                visible: showVerificationCodeField,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: const Size(double.infinity, 60)),
                    onPressed: () {
                      if (smsCode != null && smsCode!.isNotEmpty) {
                        _submitOTP(smsCode!);
                        timer!.cancel();
                      } else {
                        setState(() {
                          errorMessage = "SMS Code can not be empty.";
                          _errorFlag = true;
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
                            'Verify',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return 'Valid';
  }

  void getPhoneNumber(String phoneNumber) async {
    String phoneNumber = '+90 534 202 0204';
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'TR');
    setState(() {
      this.number = number;
    });
  }
}
