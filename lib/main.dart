import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:covid19_contact_tracking/core/services/contact_database.dart';
import 'package:covid19_contact_tracking/screens/authentication/privacy_policy.dart';
import 'package:covid19_contact_tracking/screens/authentication/profile.dart';
import 'package:covid19_contact_tracking/screens/authentication/reset_password.dart';
import 'package:covid19_contact_tracking/screens/authentication/login.dart';
import 'package:covid19_contact_tracking/screens/authentication/register.dart';
import 'package:covid19_contact_tracking/screens/authentication/signin_signup.dart';
import 'package:covid19_contact_tracking/screens/authentication/terms_and_conditions.dart';
import 'package:covid19_contact_tracking/screens/home/home.dart';
import 'package:covid19_contact_tracking/screens/pcr_antigen/pcr_antigen.dart';
import 'package:covid19_contact_tracking/screens/risk_level/risk_level.dart';
import 'package:covid19_contact_tracking/screens/settings/settings.dart';
import 'package:covid19_contact_tracking/screens/wrapper.dart';
import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<UserDatabaseService>(
          create: (_) => UserDatabaseService(),
        ),
        Provider<ContactDatabaseService>(
          create: (_) => ContactDatabaseService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Ebrima',
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/home': (context) => const HomeScreen(),
          '/signInSignUp': (context) => const SignInSignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/resetPassword': (context) => const ResetPasswordScreen(),
          '/register': (context) => const RegisterScreen(),
          '/termsAndConditions': (context) => const TermsAndConditionsScreen(),
          '/privacyPolicy': (context) => const PrivacyPolicyScreen(),
          '/pcrAntigen': (context) => const PCRAntigenScreen(),
          '/riskLevel': (context) => const RiskLevelScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/registerProfile': (context) => const RegisterProfileScreen()
        },
      ),
    );
  }
}
