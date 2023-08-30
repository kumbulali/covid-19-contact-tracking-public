import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 77, 206, 215),
            Color.fromARGB(255, 96, 209, 224)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PRIVACY POLICY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text("Last updated: May 15, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(255, 49, 49, 49),
                          fontSize: 14)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""Interpretation and Definitions   """,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Interpretation""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Definitions""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""   For the Purposes of this Privacy Policy.""",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Account""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means a unique account created for You to access our Service or parts of our Service. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Affiliate""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Appliction""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means the software program provided by the Company downloaded by You on any electronic device, named Covid-19 Contact Tracking System """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Company""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Covid-19 Contact Tracking System. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Country""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: """ refers to: Turkey """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Device""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means any device that can access the Service such as a computer, a cellphone or a digital tablet. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Personal Data""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ is any information that relates to an identified or identifiable individual. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Service""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: """ refers to the Application. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Service Provider""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 Usage Data""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit). """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 You""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Collecting and Using Your Personal Data""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""Types of Data Collected""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Personal Data""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" \u2022 Email adress""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const Text(""" \u2022 First name and last name""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const Text(""" \u2022 Phone number""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const Text(""" \u2022 Usage data""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Usage Data""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Usage Data is collected automatically when using the Service.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      """Information Collected while Using the Application""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   \u2022 Information regarding your location""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   You can enable or disable access to this information at any time, through Your Device settings. """,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Use of Your Personal Data""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """  The Company may use Personal Data for the following purposes: """,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: const TextSpan(
                                text:
                                    """ \u2022 To provide and maintain our Service""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """, including to monitor the usage of our Service. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 To manage Your Account:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text:
                                    """ \u2022 For the performance of a contract:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 To contact You:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 To provide You""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 To manage Your requests:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ To attend and manage Your requests to Us. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 For business transfers:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 For other purposes:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                            """ We may share Your personal information in the following situations:""",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16)),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 With Service Providers:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 For business transfers:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 With Affiliates:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 With business partners:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may share Your information with Our business partners to offer You certain products, services or promotions. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 With other users:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                        RichText(
                            text: const TextSpan(
                                text: """ \u2022 With Your consent:""",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          """ We may disclose Your personal information for any other purpose with Your consent. """,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ])),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Retention of Your Personal Data """,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Transfer of Your Personal Data""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Disclosure of Your Personal Data""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Business Transactions""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Law enforcement""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(""" Other legal requirements""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""  \u2022 Comply with a legal obligation""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """  \u2022 Protect and defend the rights or property of the Company""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   \u2022 Prevent or investigate possible wrongdoing in connection with the Service""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   \u2022 Protect the personal safety of Users of the Service or the public""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""  \u2022 Protect against legal liability""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("""Security of Your Personal Data""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Children's Privacy""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """  If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Links to Other Websites""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Changes to this Privacy Policy""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("""Contact Us""",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   If you have any questions about this Privacy Policy, You can contact us:""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   \u2022 By email: alikumbul@windowslive.com""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      """   \u2022 By visiting this page on our website: https://www.linkedin.com/in/ali-kumbul-ab030b178/""",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16)),
                  const SizedBox(
                    height: 80,
                  ),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/covid19-logo-512x512.png'),
                      width: 128,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
