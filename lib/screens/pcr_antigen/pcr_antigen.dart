import 'dart:io';
import 'dart:math';
import 'package:covid19_contact_tracking/core/services/storage_service.dart';
import 'package:covid19_contact_tracking/core/services/user_database.dart';
import 'package:covid19_contact_tracking/models/test_result.dart';
import 'package:covid19_contact_tracking/models/user.dart';
import 'package:covid19_contact_tracking/shared_widgets/footer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootServices;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:web_scraper/web_scraper.dart';

class PCRAntigenScreen extends StatefulWidget {
  const PCRAntigenScreen({Key? key}) : super(key: key);

  @override
  State<PCRAntigenScreen> createState() => _PCRAntigenScreenState();
}

class _PCRAntigenScreenState extends State<PCRAntigenScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  File? file;
  UploadTask? task;

  Barcode? result;
  String? errorMessage;
  final storageRef = FirebaseStorage.instance.ref();
  RegExp regExp = RegExp(
      r"((?<id>\*+[0-9]+)|(?<result>NEGATIF|NEGATIVE|NEGATİF|POSITIVE|POZITIF|POZİTİF)|(?<date>\d{1,2}\.\d{1,2}\.\d{2,4} \d{2}:\d{2}:\d{2}))");
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected.';
    UserDatabaseService userDatabaseService =
        Provider.of<UserDatabaseService>(context);

    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('PCR / ANTIGEN'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 77, 206, 215),
      ),
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 80, left: 24, bottom: 36, right: 24),
                child: Text(
                  'Upload your PCR / Antigen Test result in order to get a current status.',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, left: 24.0, bottom: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "PCR / ANTIGEN TEST RESULT",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 24.0, left: 24, bottom: 0, top: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.white),
                    elevation: 2,
                    primary: const Color.fromARGB(255, 142, 222, 229),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 64),
                  ),
                  onPressed: () async {
                    await selectFile();
                    if (file != null) {
                      setState(() {
                        errorMessage = "";
                      });
                    }
                  },
                  child: Text(
                    fileName,
                    style: TextStyle(fontSize: file == null ? 24 : 16),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 38.0, left: 38.0, bottom: 8),
                  child: task != null
                      ? StreamBuilder<TaskSnapshot>(
                          stream: task?.snapshotEvents,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final snap = snapshot.data!;
                              print(snap.bytesTransferred);
                              double progress =
                                  snap.bytesTransferred / snap.totalBytes;

                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                height: 2,
                                child: LinearProgressIndicator(
                                  value: progress,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Container(
                                height: 2,
                              );
                            }
                          },
                        )
                      : Container(
                          height: 2,
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: errorMessage != null,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 55),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          errorMessage ?? '',
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24, bottom: 24),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: const Size(140, 50),
                      ),
                      onPressed: _loading
                          ? null
                          : () async {
                              if (file == null) {
                                setState(() {
                                  errorMessage = 'Please select a file.';
                                });
                              } else {
                                setState(() {
                                  errorMessage = '';
                                  _loading = true;
                                });
                                final destination =
                                    'pcr_antigen_tests/${userDatabaseService.user.uid}_${DateTime.now().toString()}.png';

                                try {
                                  final imageFile =
                                      await pdftoImageConvert(file!);
                                  setState(() {
                                    task = StorageService.uploadFile(
                                        destination, imageFile);
                                  });
                                } on FirebaseException catch (e) {
                                  setState(() {
                                    errorMessage = e.message;
                                    _loading = false;
                                  });
                                }

                                if (task == null) return;

                                final snapshot =
                                    await task!.whenComplete(() {});
                                final urlDownload =
                                    await snapshot.ref.getDownloadURL();
                                print('Download-Link: $urlDownload');
                                try {
                                  Barcode result = await scanner
                                      .processImage(InputImage.fromFile(
                                          await urlToFile(urlDownload)))
                                      .then((value) => value.first);
                                  print('Scan-Result: ${result.rawValue}');
                                  getHealthStatusFromURL(result.rawValue!)
                                      .then((value) {
                                    print(value.citizenshipID);
                                    print(value.result);
                                    print(value.testDate);
                                    print(value.testResultID);
                                    //if (value.testDate!.compareTo(DateTime(now.year, now.month, now.day - 3)) > 0) {
                                    //uncomment above line and remove the line below to accept only the pcr/antigen tests that are taken in 72 hours.
                                    if (true) {
                                      if (["NEGATİF", 'NEGATIF', 'NEGATIVE']
                                          .contains(value.result)) {
                                        userDatabaseService
                                            .updateUsersHealthStatus(
                                                HealthStatus.riskless);
                                      } else if ([
                                        'POZİTİF',
                                        'POZITIF',
                                        'POSITIVE'
                                      ].contains(value.result)) {
                                        userDatabaseService
                                            .updateUsersHealthStatus(
                                                HealthStatus.infected);
                                      } else {
                                        setState(() {
                                          errorMessage =
                                              'Health status could not be detected.';
                                        });
                                        userDatabaseService
                                            .updateUsersHealthStatus(
                                                HealthStatus.unknown);
                                      }
                                    } else {
                                      setState(() {
                                        errorMessage =
                                            'PCR/Antigen test is outdated.';
                                      });
                                      snapshot.ref.delete();
                                    }
                                  });
                                } catch (e) {
                                  setState(() {
                                    errorMessage = e.toString();
                                    _loading = false;
                                    task = null;
                                  });
                                }
                                setState(() {
                                  _loading = false;
                                  task = null;
                                });
                              }
                            },
                      child: _loading
                          ? const SpinKitChasingDots(
                              color: Colors.black,
                              size: 32,
                            )
                          : const Text(
                              "Upload",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, top: 8, bottom: 48, right: 24),
                child: Text(
                  "Note that PCR/Antigen tests are valid for 72 hours.",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                ),
              )
            ]),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [],
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

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future<File> pdftoImageConvert(File pdfFile) async {
    final document = await PdfDocument.openFile(pdfFile.path);
    final page = await document.getPage(1);
    final pageImage = await page.render(
        width: page.width * 2,
        height: page.height * 2,
        format: PdfPageImageFormat.png,
        backgroundColor: '#ffffff',
        quality: 100);
    await page.close();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final file = File('${tempPath}/file_01.tmp');
    return file.writeAsBytes(pageImage!.bytes);
  }

  BarcodeScanner scanner = BarcodeScanner(formats: [
    BarcodeFormat.qrCode,
    BarcodeFormat.dataMatrix,
  ]);
  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future<TestResult> getHealthStatusFromURL(String url) async {
    Uri uri = Uri.parse(url);
    final webScraper = WebScraper();
    await webScraper.loadFullURL(uri.toString());
    if (uri.host == 'covid.gov.ct.tr') {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('div.redBorder > h3 > span', []);
      return TestResult(
          citizenshipID: elements[0]['title'],
          testResultID: elements[1]['title'],
          testDate: DateFormat('dd/MM/yyyy hh:mm').parse(elements[2]['title']),
          result: elements[3]['title']);
    } else if (uri.host == 'enabiz.gov.tr') {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('div > p.note', []);

      List result_info = regExp
          .allMatches(elements.first.toString())
          .map((match) => match.group(0))
          .toList();
      return TestResult(
          citizenshipID: result_info[0],
          testResultID: uri.queryParameters['barcode'],
          testDate: DateFormat('dd.MM.yyyy hh:mm:ss').parse(
            result_info[2],
          ),
          result: result_info[1]);
    } else {
      return TestResult();
    }
  }
}
