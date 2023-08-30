import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  const DrawerListTile(
      {Key? key, required this.title, required this.route, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 32),
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 24)),
      onTap: () {
        Navigator.popAndPushNamed(context, route);
      },
    );
  }
}
