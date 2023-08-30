import 'package:covid19_contact_tracking/models/user.dart';
import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:covid19_contact_tracking/utils/border_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String errorMessage = 'Default Error Message';
  bool _errorFlag = false;
  bool _loading = false;
  bool _isObscure = true;
  bool _isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String initialCountry = 'TR';
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userDatabaseService = Provider.of<UserDatabaseService>(context);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.white;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 77, 206, 215),
              Color.fromARGB(255, 96, 209, 224)
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Register',
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
                    "Email",
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
                  controller: _emailController,
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
                      hintText: 'example@emu.edu.tr',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: _emailController.clear,
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
                    "Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16, top: 8, bottom: 8),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.cyan,
                  controller: _passwordController,
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
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
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              style: const TextStyle(fontSize: 16),
                              children: [
                            const TextSpan(text: "I agree with the "),
                            TextSpan(
                              style: const TextStyle(color: Colors.blue),
                              text: "terms and conditions",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, '/termsAndConditions'),
                            ),
                            const TextSpan(text: ", "),
                            TextSpan(
                              style: const TextStyle(color: Colors.blue),
                              text: "privacy policy",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, '/privacyPolicy'),
                            ),
                            const TextSpan(
                                text:
                                    " and also the protection of my personal data on this application.")
                          ])),
                    )
                  ],
                ),
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
                  onPressed: _loading || !_isChecked
                      ? null
                      : () async {
                          if (_passwordController.text.isEmpty ||
                              _emailController.text.isEmpty) {
                            errorMessage =
                                "Password or Email can not be empty.";
                            setState(() {
                              _errorFlag = true;
                            });
                          } else {
                            setState(() {
                              _loading = true;
                            });
                            Object? user = await authService
                                .createUserWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);
                            setState(() {
                              _loading = false;
                            });
                            if (user is User) {
                              userDatabaseService.createUserData(user);
                              Navigator.pop(context);
                            }
                            if (user is FirebaseAuthException) {
                              setState(() {
                                errorMessage = authService
                                    .getMessageFromErrorCode(user.code);
                                _errorFlag = true;
                              });
                            }
                          }
                        },
                  child: _loading
                      ? const SpinKitChasingDots(
                          color: Colors.black,
                          size: 32,
                        )
                      : const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
              )
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
