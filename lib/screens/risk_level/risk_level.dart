import 'package:covid19_contact_tracking/core/services/contact_database.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/models/contact.dart';
import 'package:covid19_contact_tracking/shared_widgets/footer.dart';
import 'package:covid19_contact_tracking/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RiskLevelScreen extends StatefulWidget {
  const RiskLevelScreen({Key? key}) : super(key: key);

  @override
  State<RiskLevelScreen> createState() => _RiskLevelScreenState();
}

class _RiskLevelScreenState extends State<RiskLevelScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserDatabaseService userDatabaseService =
        Provider.of<UserDatabaseService>(context);
    ContactDatabaseService contactDatabaseService =
        Provider.of<ContactDatabaseService>(context);
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('RISK LEVEL'),
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 77, 206, 215),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/registerProfile');
              }),
        ],
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
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Full Name:",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text(
                              "${userDatabaseService.user.name!.toUpperCase()} ${userDatabaseService.user.surname!.toUpperCase()}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 77, 206, 215),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sex:",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text(
                              userDatabaseService.user.sex!
                                  .toShortString()
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 77, 206, 215),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Age:",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text(
                              "${userDatabaseService.user.calculateAge()}",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 77, 206, 215),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Health Status:",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text(
                              userDatabaseService.user.healthStatus!
                                  .toShortString()
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: userDatabaseService.user.healthStatus!
                                            .toShortString() ==
                                        'infected'
                                    ? Colors.red
                                    : userDatabaseService.user.healthStatus!
                                                .toShortString() ==
                                            'contacted'
                                        ? Colors.amber
                                        : userDatabaseService.user.healthStatus!
                                                    .toShortString() ==
                                                'riskless'
                                            ? Colors.lightGreen
                                            : Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone Number:",
                                style: GoogleFonts.poppins(fontSize: 18)),
                            Text(
                              userDatabaseService.user.phone.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 77, 206, 215),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text("Contacted People Today",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    StreamBuilder<List<Contact>?>(
                      stream: contactDatabaseService
                          .getContactData(userDatabaseService.user.uid),
                      builder: (_, AsyncSnapshot<List<Contact>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final contactsData = snapshot.data;
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator(
                              strokeWidth: 48,
                              color: Color.fromARGB(255, 77, 206, 215),
                            );
                          } else {
                            return Text(
                              contactsData!.length.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 72,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber),
                            );
                          }
                        }
                        return const CircularProgressIndicator(
                          strokeWidth: 48,
                          color: Color.fromARGB(255, 77, 206, 215),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text('Contact counts for the last 5 days',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <LineSeries<ContactsData, String>>[
                            LineSeries<ContactsData, String>(
                                name: "Contacted People Count",
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                dataSource: <ContactsData>[
                                  ContactsData(
                                      DateFormat('EEEE').format(DateTime(
                                          now.year, now.month, now.day - 5)),
                                      userDatabaseService
                                          .user.lastContactNumbers[4]),
                                  ContactsData(
                                      DateFormat('EEEE').format(DateTime(
                                          now.year, now.month, now.day - 4)),
                                      userDatabaseService
                                          .user.lastContactNumbers[3]),
                                  ContactsData(
                                      DateFormat('EEEE').format(DateTime(
                                          now.year, now.month, now.day - 3)),
                                      userDatabaseService
                                          .user.lastContactNumbers[2]),
                                  ContactsData(
                                      DateFormat('EEEE').format(DateTime(
                                          now.year, now.month, now.day - 2)),
                                      userDatabaseService
                                          .user.lastContactNumbers[1]),
                                  ContactsData(
                                      'Yesterday',
                                      userDatabaseService
                                          .user.lastContactNumbers[0])
                                ],
                                xValueMapper: (ContactsData sales, _) =>
                                    sales.day,
                                yValueMapper: (ContactsData sales, _) =>
                                    sales.contacts)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Footer()
        ],
      ),
    );
  }
}

class ContactsData {
  ContactsData(this.day, this.contacts);
  final String day;
  final int contacts;
}
