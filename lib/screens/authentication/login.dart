// ignore_for_file: unnecessary_new

import 'package:covid19_contact_tracking/models/user.dart';
import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:covid19_contact_tracking/utils/border_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = 'Default Error Message';
  bool _errorFlag = false;
  bool loading = false;
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 77, 206, 215),
            Color.fromARGB(255, 96, 209, 224)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Login',
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
                    right: 16.0, left: 16.0, top: 8, bottom: 8),
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
              const SizedBox(height: 8),
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
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.cyan,
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 142, 222, 229),
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const Text(
                    "Forgot password? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/resetPassword');
                    },
                    child: const Text(
                      "Reset password.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ]),
              ),
              Visibility(
                  visible: _errorFlag,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: loading
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
                              loading = true;
                            });
                            Object? user =
                                await authService.signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);

                            setState(() {
                              loading = false;
                            });
                            if (user is User) {
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
                  child: loading
                      ? const SpinKitChasingDots(
                          color: Colors.black,
                          size: 32,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
