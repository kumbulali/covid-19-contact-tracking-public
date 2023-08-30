// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({Key? key}) : super(key: key);
  @override
  _SignInSignUpScreenState createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color.fromARGB(255, 77, 206, 215),
                Color.fromARGB(255, 96, 209, 224)
              ])),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Image(
                    image: AssetImage('assets/covid19-logo-512x512.png'),
                    height: 128,
                  ),
                ),
                const Center(
                    child: Text(
                  "Covid-19 Contact\nTracking System",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Sign in if you already have an account.",
                        style: TextStyle(color: Colors.black45, fontSize: 18)),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(32)),
                              primary: Colors.cyan,
                              onPrimary: Colors.white,
                              minimumSize: const Size(double.infinity, 60)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(fontSize: 24),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text("Or sign up if you are new!",
                        style: TextStyle(color: Colors.black45, fontSize: 18)),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(32)),
                            primary: Colors.cyan,
                            onPrimary: Colors.white,
                            minimumSize: const Size(double.infinity, 60)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ]),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(-1.0, -1.0))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.6,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
