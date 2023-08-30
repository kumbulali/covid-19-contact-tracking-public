import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/core/services/contact_database.dart';
import 'package:covid19_contact_tracking/models/user.dart';
import 'package:covid19_contact_tracking/screens/authentication/phone_number.dart';
import 'package:covid19_contact_tracking/screens/authentication/profile.dart';
import 'package:covid19_contact_tracking/screens/authentication/signin_signup.dart';
import 'package:covid19_contact_tracking/screens/home/home.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoCheckWrapper extends StatefulWidget {
  final User? user;

  const UserInfoCheckWrapper({Key? key, this.user}) : super(key: key);

  @override
  State<UserInfoCheckWrapper> createState() => _UserInfoCheckWrapperState();
}

class _UserInfoCheckWrapperState extends State<UserInfoCheckWrapper>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final userDatabaseService = Provider.of<UserDatabaseService>(context);
    final contactDatabaseService = Provider.of<ContactDatabaseService>(context);
    final DateTime now = DateTime.now();
    userDatabaseService.user = widget.user!;
    final authService = Provider.of<AuthService>(context);
    void signOut() async {
      await authService.signOut();
    }

    void _fetchContactCounts() async {
      userDatabaseService.user.lastContactNumbers[0] =
          await contactDatabaseService.getContactCountByDate(
              DateTime(now.year, now.month, now.day - 1),
              userDatabaseService.user.uid);
      userDatabaseService.user.lastContactNumbers[1] =
          await contactDatabaseService.getContactCountByDate(
              DateTime(now.year, now.month, now.day - 2),
              userDatabaseService.user.uid);
      userDatabaseService.user.lastContactNumbers[2] =
          await contactDatabaseService.getContactCountByDate(
              DateTime(now.year, now.month, now.day - 3),
              userDatabaseService.user.uid);
      userDatabaseService.user.lastContactNumbers[3] =
          await contactDatabaseService.getContactCountByDate(
              DateTime(now.year, now.month, now.day - 4),
              userDatabaseService.user.uid);
      userDatabaseService.user.lastContactNumbers[4] =
          await contactDatabaseService.getContactCountByDate(
              DateTime(now.year, now.month, now.day - 5),
              userDatabaseService.user.uid);
    }

    return StreamBuilder<User?>(
      stream: userDatabaseService.userData,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final userData = snapshot.data;
          // print("${user?.email}  ->  user_info_check_wrapper.dart");
          // print("${userData?.email}  email->  user_info_check_wrapper.dart");
          // print("${userData?.name}  name->  user_info_check_wrapper.dart");
          // print(
          //     "${userData?.surname}  surname->  user_info_check_wrapper.dart");
          // print("${userData?.birthDate}  age->  user_info_check_wrapper.dart");
          // print("${userData?.phone}  phone->  user_info_check_wrapper.dart");
          if (snapshot.data == null) {
            signOut();
            // print("logged out");
            return const SignInSignUpScreen();
          } else {
            if (userData?.phone == null) {
              return const RegisterPhoneScreen();
            } else if ([
              userData?.birthDate,
              userData?.name,
              userData?.surname,
              userData?.citizenshipID,
              userData?.sex
            ].contains(null)) {
              return const RegisterProfileScreen();
            } else {
              _fetchContactCounts();
              return const HomeScreen();
            }
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
