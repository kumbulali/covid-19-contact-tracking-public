import 'package:covid19_contact_tracking/models/user.dart';
import 'package:covid19_contact_tracking/screens/authentication/signin_signup.dart';
import 'package:covid19_contact_tracking/screens/loading.dart';
import 'package:covid19_contact_tracking/screens/user_info_check_wrapper.dart';
import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          //print("${user?.email} -> wrapper.dart");
          return user == null
              ? const SignInSignUpScreen()
              : UserInfoCheckWrapper(
                  user: user,
                );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
