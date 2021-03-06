import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmsmobile/apiService/apiService.dart';
import 'package:rmsmobile/pages/login/login.dart';
import 'package:rmsmobile/utils/warna.dart';
import 'package:rmsmobile/widget/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:rmsmobile/utils/warna.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late SharedPreferences sp;
  late FirebaseMessaging messaging;
  ApiService _apiService = new ApiService();
  String? token = "", username = "", jabatan = "";
  bool subscribepermintaan = true;
  bool subscribeprogress = true;

  cekToken() async {
    sp = await SharedPreferences.getInstance();
    // token = sp.getString("access_token");
    // username = sp.getString("username");
    // jabatan = sp.getString("jabatan");
    setState(() {
      token = sp.getString("access_token");
      username = sp.getString("username");
      jabatan = sp.getString("jabatan");
    });
    print('tokenyya $token ${_apiService.responseCode.messageApi}');
    if (token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginscreen()));
    } else {
      print(
          'responsecode ${_apiService.responseCode.messageApi} ++ ${_apiService.responseCode} ++ ');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    }
  }

  @override
  void initState() {
    super.initState();
    // * adding firebase configuration setup
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    // ++ SUBSCRIBE TOPIC RMS PERMINTAAN
    if (subscribepermintaan) {
      // messaging.subscribeToTopic('RMSPERMINTAAN');
      messaging.subscribeToTopic('RMSPERMINTAAN');
    } else {
      // messaging.unsubscribeFromTopic('RMSPERMINTAAN');
      messaging.unsubscribeFromTopic('RMSPERMINTAAN');
    }
    // ++ SUBSCRIBE TOPIC RMSPROGRESS
    if (subscribeprogress) {
      // messaging.subscribeToTopic('RMSPROGRESS');
      messaging.subscribeToTopic('RMSPROGRESS');
    } else {
      // messaging.unsubscribeFromTopic('RMSPROGRESS');
      messaging.unsubscribeFromTopic('RMSPROGRESS');
    }
    Timer(Duration(seconds: 4), () {
      cekToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/1.png'), fit: BoxFit.cover),
            gradient: LinearGradient(
                colors: [Color(0xffCCE9CC), thirdcolor],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        // color: Color(0xFEEFD8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/bnllauncher.png',
                            ),
                            fit: BoxFit.contain)),
                  ),
                  Text('BNL-RMS',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 30),
                    child: Text(
                      'Memberikan solusi terbaik untuk kemudahan anda dalam menyelesaikan sebuah masalah.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    ),
                  )
                  // LinearPercentIndicator(
                  //   alignment: MainAxisAlignment.center,
                  //   width: 240.0,
                  //   lineHeight: 4.0,
                  //   animation: true,
                  //   percent: 1.0,
                  //   animationDuration: 1250,
                  //   backgroundColor: Colors.red,
                  //   progressColor: Colors.white,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomSheet:
      //     Image(image: AssetImage('assets/images/splashgif.gif'), fit: BoxFit.fitWidth),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
