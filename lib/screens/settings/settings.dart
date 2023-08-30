import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:covid19_contact_tracking/core/services/auth_service.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/shared_widgets/footer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool notificationsBool = false;
  bool bluetoothBool = false;
  bool locationBool = false;
  bool? backgroundBool;
  bool _isLoading = false;
  final beaconBroadcast = Get.find<BeaconBroadcast>();
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    UserDatabaseService userDatabaseService =
        Provider.of<UserDatabaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS'),
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 77, 206, 215),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 77, 206, 215),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.notifications_outlined,
                        size: 48,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Notifications",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: Switch(
                        value: notificationsBool,
                        onChanged: (_) {
                          setState(() {
                            notificationsBool = !notificationsBool;
                          });
                        },
                        activeColor: const Color.fromRGBO(77, 206, 215, 1),
                        activeTrackColor:
                            const Color.fromRGBO(182, 234, 237, 1),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.bluetooth_outlined,
                      size: 48,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Bluetooth",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Switch(
                      value: bluetoothBool,
                      onChanged: (_) {
                        setState(() {
                          bluetoothBool = !bluetoothBool;
                        });
                      },
                      activeColor: const Color.fromRGBO(77, 206, 215, 1),
                      activeTrackColor: const Color.fromRGBO(182, 234, 237, 1),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      size: 48,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Location Services",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Switch(
                      value: locationBool,
                      onChanged: (_) {
                        setState(() {
                          locationBool = !locationBool;
                        });
                      },
                      activeColor: const Color.fromRGBO(77, 206, 215, 1),
                      activeTrackColor: const Color.fromRGBO(182, 234, 237, 1),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await authService.signOut();
                      await BeaconsPlugin.stopMonitoring();
                      beaconBroadcast.stop();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 48,
                      ),
                      title: Text(
                        "Sign Out",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 157,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Please note that in order for this program to work as expected, your bluetooth, wifi and location services must remain on.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Footer()
        ],
      ),
    );
  }
}
