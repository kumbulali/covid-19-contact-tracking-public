import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:covid19_contact_tracking/core/services/contact_database.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/models/contact.dart';
import 'package:covid19_contact_tracking/screens/home/widgets/customCard.dart';
import 'package:covid19_contact_tracking/shared_widgets/customDrawer.dart';
import 'package:covid19_contact_tracking/shared_widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final dataMap = <String, double>{
    "Flutter": 5,
  };
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  bool _isInForeground = true;
  var isRunning = false;
  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  bool _isAdvertising = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_bg_service_small');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UserDatabaseService userDatabaseService =
          context.read<UserDatabaseService>();
      ContactDatabaseService contactDatabaseService =
          context.read<ContactDatabaseService>();

      beaconBroadcast.checkTransmissionSupported().then((isSupported) {
        if (isSupported == BeaconStatus.supported) {
          beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
            _isAdvertising = isAdvertising;
          });
          beaconBroadcast
              .setUUID(userDatabaseService.user.ucid.toString())
              .setMajorId(1)
              .setMinorId(100)
              .setLayout('m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24')
              .setManufacturerId(0x004c)
              .start();
        } else {
          print('Beacon service is not supported.');
        }
      });

      if (Platform.isAndroid) {
        //Prominent disclosure
        await BeaconsPlugin.setDisclosureDialogMessage(
            title: "Prominent Disclosure",
            message:
                "Contact Tracking app uses BLE and Location services to detect nearby devices.");

        //Only in case, you want the dialog to be shown again. By Default, dialog will never be shown if permissions are granted.
        //await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
      }

      if (Platform.isAndroid) {
        BeaconsPlugin.channel.setMethodCallHandler((call) async {
          print("Method: ${call.method}");
          if (call.method == 'scannerReady') {
            print("Beacons monitoring started..");
            await BeaconsPlugin.startMonitoring();
            setState(() {
              isRunning = true;
            });
          } else if (call.method == 'isPermissionDialogShown') {
            print("Prominent disclosure message is shown to the user!");
          }
        });
      } else if (Platform.isIOS) {
        print("Beacons monitoring started..");
        await BeaconsPlugin.startMonitoring();
        setState(() {
          isRunning = true;
        });
      }

      await BeaconsPlugin.listenToBeacons(beaconEventsController);

      await BeaconsPlugin.runInBackground(true);

      await BeaconsPlugin.addBeaconLayoutForAndroid(
          'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24');

      await BeaconsPlugin.setForegroundScanPeriodForAndroid(
          foregroundScanPeriod: 2000, foregroundBetweenScanPeriod: 3000);

      await BeaconsPlugin.setBackgroundScanPeriodForAndroid(
          backgroundScanPeriod: 2000, backgroundBetweenScanPeriod: 3000);

      beaconEventsController.stream.listen(
          (data) async {
            if (data.isNotEmpty && isRunning) {
              print(data);
              await userDatabaseService
                  .isUcidExists(
                      json.decode(data)['uuid'].toString().replaceAll('-', ''))
                  .then((isExists) async {
                if (isExists) {
                  await contactDatabaseService.isContactedToday([
                    json.decode(data)['uuid'].toString().replaceAll('-', ''),
                    userDatabaseService.user.ucid!
                  ]).then((isContactedToday) async {
                    if (!isContactedToday) {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.low);
                      contactDatabaseService.createContact(Contact(
                          contactLat: position.latitude.toDouble(),
                          contactLong: position.longitude.toDouble(),
                          contactUCIDs: [
                            json
                                .decode(data)['uuid']
                                .toString()
                                .replaceAll('-', '')
                                .toUpperCase(),
                            userDatabaseService.user.ucid!.toUpperCase()
                          ],
                          contactUIDs: [
                            userDatabaseService.user.uid,
                            await userDatabaseService.getUidFromUcid(json
                                .decode(data)['uuid']
                                .toString()
                                .replaceAll('-', '')
                                .toUpperCase())
                          ]));
                    } else {
                      //if contacted today
                      print('this address is already contacted.');
                    }
                  });
                } else {
                  //ucid not valid do nothing
                  print('ucid not valid');
                }
              });
            }
          },
          onDone: () {},
          onError: (error) {
            print("Error: $error");
          });

      if (!mounted) return;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    beaconEventsController.close();
    beaconBroadcast.stop();
    Get.deleteAll();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserDatabaseService userDatabaseService =
        Provider.of<UserDatabaseService>(context);
    ContactDatabaseService contactDatabaseService =
        Provider.of<ContactDatabaseService>(context);
    Get.put(beaconBroadcast);
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 77, 206, 215),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 80,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Hello, ${userDatabaseService.user.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                            icon: Icons.health_and_safety,
                            onTap: () {
                              Navigator.pushNamed(context, '/pcrAntigen');
                            },
                            title: 'PCR/Antigen'),
                        CustomCard(
                            onTap: () {
                              Navigator.pushNamed(context, '/riskLevel');
                            },
                            icon: Icons.security_update_warning,
                            title: 'Risk Level'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        'Contacted People Today',
                        style: GoogleFonts.inter(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: StreamBuilder<List<Contact>?>(
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
                                return PieChart(
                                  baseChartColor:
                                      const Color.fromARGB(255, 77, 206, 215),
                                  colorList: contactsData!.length < 10
                                      ? const [Colors.lightGreen]
                                      : contactsData.length < 40
                                          ? const [Colors.amber]
                                          : const [Colors.red],
                                  centerText: contactsData.length.toString(),
                                  centerTextStyle: TextStyle(
                                      fontSize: 64,
                                      color: contactsData.length < 10
                                          ? Colors.lightGreen
                                          : contactsData.length < 40
                                              ? Colors.amber
                                              : Colors.red,
                                      fontWeight: FontWeight.bold),
                                  dataMap: dataMap,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 64,
                                  legendOptions:
                                      const LegendOptions(showLegends: false),
                                  chartValuesOptions: const ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: false),
                                );
                              }
                            }
                            return const CircularProgressIndicator(
                              strokeWidth: 48,
                              color: Color.fromARGB(255, 77, 206, 215),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        "Please remember to wear your masks\nand make sure that your mouth and\nnose are covered.",
                        textAlign: TextAlign.center,
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
