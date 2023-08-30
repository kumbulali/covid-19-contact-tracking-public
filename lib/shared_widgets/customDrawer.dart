import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/shared_widgets/drawerDivider.dart';
import 'package:covid19_contact_tracking/shared_widgets/drawerListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDatabaseService userDatabaseService =
        Provider.of<UserDatabaseService>(context);
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 77, 206, 215),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  child: Text("Hello, ${userDatabaseService.user.name}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              const DrawerDivider(),
              const DrawerListTile(
                icon: Icons.health_and_safety,
                title: 'PCR / ANTIGEN',
                route: '/pcrAntigen',
              ),
              const DrawerDivider(),
              const DrawerListTile(
                  title: 'RISK LEVEL',
                  route: '/riskLevel',
                  icon: Icons.security_update_warning),
              const DrawerDivider()
            ],
          ),
          Column(
            children: const [
              DrawerListTile(
                  icon: Icons.settings, title: 'SETTINGS', route: '/settings'),
              SizedBox(
                height: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}
