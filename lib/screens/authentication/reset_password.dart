import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/utils/border_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String errorMessage = 'Default Error Message';
  bool _errorFlag = false;
  bool _sentFlag = false;
  bool _loading = false;
  final TextEditingController _emailController = TextEditingController();

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
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Reset password',
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
              Visibility(
                visible: _errorFlag,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Visibility(
                visible: _sentFlag,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    "Password reset email is sent.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      //elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: const Size(double.infinity, 60)),
                  onPressed: _loading
                      ? null
                      : () async {
                          if (_emailController.text.isEmpty) {
                            errorMessage =
                                "Password or Email can not be empty.";
                            setState(() {
                              _errorFlag = true;
                            });
                          } else {
                            setState(() {
                              _loading = true;
                            });
                            try {
                              await authService.sendPasswordResetEmail(
                                  _emailController.text.trim());
                              setState(() {
                                _sentFlag = true;
                                _errorFlag = false;
                                _loading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                errorMessage =
                                    authService.getMessageFromErrorCode(e.code);
                                _errorFlag = true;
                                _loading = false;
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
                          'Reset password',
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
