import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import 'accountpage.dart';
import 'domainspage.dart';
import 'eventspage.dart';
import 'homepage.dart';
import 'notificationpage.dart';
import '../theme/themeprovider.dart';

class navigationpage extends StatefulWidget {
  const navigationpage({super.key});

  @override
  State<navigationpage> createState() => _navigationpageState();
}

class _navigationpageState extends State<navigationpage> {
  List pages = [
    const homepage(),
    const eventspage(),
    const domainspage(),
    const notificationpage(),
    const accountpage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
      bottomNavigationBar: GNav(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        activeColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        selectedIndex: _selectedIndex,
        gap: 5,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home, // required but will be ignored visually
            text: '', // suppress default label
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex == 0
                    ? const Icon(Icons.home_rounded, color: Colors.white)
                    : const Icon(Icons.home_rounded, color: Colors.white38),
                const SizedBox(height: 4),
                _selectedIndex == 0
                    ? const Text("Home",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                    : const Text("Home",
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          GButton(
            icon: Icons.home, // required but will be ignored visually
            text: '', // suppress default label
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex == 1
                    ? Icon(Icons.calendar_month_outlined, color: Colors.white)
                    : Icon(Icons.calendar_month_outlined,
                        color: Colors.white38),
                const SizedBox(height: 4),
                _selectedIndex == 1
                    ? Text("Events",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                    : Text("Events",
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          GButton(
            icon: Icons.home, // required but will be ignored visually
            text: '', // suppress default label
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex == 2
                    ? const Icon(Icons.apps_outlined, color: Colors.white)
                    : const Icon(Icons.apps_outlined, color: Colors.white38),
                const SizedBox(height: 4),
                _selectedIndex == 2
                    ? const Text("Domains",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                    : const Text("Domains",
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          GButton(
            icon: Icons.home, // required but will be ignored visually
            text: '', // suppress default label
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex == 3
                    ? const Icon(Icons.notifications_outlined, color: Colors.white)
                    : const Icon(Icons.notifications_outlined, color: Colors.white38),
                const SizedBox(height: 4),
                _selectedIndex == 3
                    ? const Text("Alerts",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                    : const Text("Alerts",
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          GButton(
            icon: Icons
                .account_circle_outlined, // required but will be ignored visually
            text: '', // suppress default label
            leading: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectedIndex == 4
                    ? const Icon(Icons.account_circle_outlined, color: Colors.white)
                    : const Icon(Icons.account_circle_outlined,
                        color: Colors.white38),
                const SizedBox(height: 4),
                _selectedIndex == 4
                    ? const Text("Account",
                        style: TextStyle(color: Colors.white, fontSize: 12))
                    : const Text("Account",
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),


      body: pages[_selectedIndex],
    );
  }
}
