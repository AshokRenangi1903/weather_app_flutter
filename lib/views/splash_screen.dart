import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/resources/constants.dart';
import 'package:weather_app/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // color: Colors.red,
            height: MediaQuery.sizeOf(context).height,
            child: Image.asset(
              'lib/resources/weather app logo.png',
              width: MediaQuery.sizeOf(context).width * 0.8,
            ),
          ),
          Positioned(
            bottom: 40,
            child: Container(
              // color: Colors.amber,
              // height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Developed By-"),
                  Text(
                    "ASHOK RENANGI",
                    style: GoogleFonts.ubuntu(
                        fontSize: 28,
                        color: MyColors.darkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
