import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/resources/constants.dart';

class ContainerBox extends StatelessWidget {
  IconData? icon;
  String? text;
  String? value;
  ContainerBox({super.key, this.icon, this.text, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            MyColors.darkBlue,
            MyColors.lightBlue,
            Colors.white,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text!,
            style: GoogleFonts.ubuntu(color: MyColors.darkBlue),
          ),
          const SizedBox(
            height: 5,
          ),
          Icon(
            icon,
            size: 28,
            color: MyColors.darkBlue,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value!,
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
