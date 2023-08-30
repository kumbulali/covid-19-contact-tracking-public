import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  const CustomCard(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 64,
                color: const Color.fromARGB(255, 77, 206, 215),
              ),
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w200, fontSize: 14))
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.only(top: 20),
    );
  }
}
