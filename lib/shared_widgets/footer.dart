import 'package:covid19_contact_tracking/core/services/contact_database.dart';
import 'package:covid19_contact_tracking/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactDatabaseService contactDatabaseService =
        Provider.of<ContactDatabaseService>(context);
    return Container(
      height: 48,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () {
              contactDatabaseService.createContact(Contact(
                  contactLat: 35.1233,
                  contactLong: 33.1223,
                  contactUCIDs: [
                    "98CEDB9A5FF21B24EFCACCD0E0F4D22C",
                    "A0C82E411432D3D4A893F2F234616477"
                  ],
                  contactUIDs: [
                    "gSTFBCjpLzb0IB9wEmelYNmceel1",
                    "05NnW5jWJjQ0q2tDgPhU3OQX2Nq1"
                  ]));
            },
            child: const Image(
              image: AssetImage('assets/covid19-logo-128x128.png'),
              height: 32,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Covid-19 Contact Tracking System',
            style: GoogleFonts.inter(fontWeight: FontWeight.w200, fontSize: 16),
          ),
        )
      ]),
    );
  }
}
