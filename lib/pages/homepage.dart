import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../theme/themeprovider.dart';
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // prevents default spacing for leading
      title: Row(
        children: [
          Image.asset(
            "lib/images/iste_logo.png",
            height: 40, // control size
            width: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8), // control space between logo and text
          Text(
            'ISTE Manipal',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            Provider.of<themeprovider>(context, listen: false).toggletheme();
          },
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: HexColor("171830"))),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.onSecondary
            ],
            stops: [0.1, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 10,
    ),


    backgroundColor:Theme.of(context).colorScheme.surface,
      body: Center(child: Text(" Home Page",style: TextStyle(color: Theme.of(context).colorScheme.primary),)),

    );
  }
}
