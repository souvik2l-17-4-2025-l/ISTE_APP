import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../theme/themeprovider.dart';
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    final colorScheme =theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // prevents default spacing for leading
      title: Row(
        children: [
          Image.asset(
            "lib/assets/images/logo.png",
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
              colorScheme.onPrimary,colorScheme.onSecondary
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
      body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("4A6AF2"), HexColor("050325")],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to ISTE',
                    style: GoogleFonts.manrope(
                      color: colorScheme.primary,
                      fontSize: 47,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your gateway to tech\n design, and innovation',
                    style: GoogleFonts.manrope(
                      color: Color(0xffffffff),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Access Section
            Text(
              'Quick Access',
              style: GoogleFonts.manrope(
                color: colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 140,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAccessCard(context, Icons.lightbulb_outline, 'Explore Domains'),
                    const SizedBox(width: 12),
                    _buildAccessCard(context, Icons.menu_book, 'View Resources'),
                    const SizedBox(width: 12),
                    _buildAccessCard(context, Icons.explore, 'Explore Projects'),
                    const SizedBox(width: 12),
                    _buildAccessCard(context, Icons.event, 'Upcoming Events'),
                  ],
                ),
              ),
            ),

            //Featured Events Section
            const SizedBox(height: 32),
            Text(
              'Featured Events',
              style: GoogleFonts.manrope(
                color: colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      'lib/assets/images/featured_event.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to Build a Strong Team',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Thursday, 7:00 PM',
                          style: GoogleFonts.manrope(fontSize: 13, color: Colors.white),
                        ),
                        Text(
                          'ISTE Manipal',
                          style: GoogleFonts.manrope(fontSize: 13, color:  Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Other Events
            const SizedBox(height: 28),
            Text(
              'Other Events',
              style: GoogleFonts.manrope(
                color: colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildEventCard(
                      context,
                      'lib/assets/images/aiml.webp',
                      'Webinar on AI in Education',
                      'Wed, 12/11',
                    ),
                    const SizedBox(width: 12),
                    _buildEventCard(
                      context,
                      'lib/assets/images/leadership.png',
                      'ISTE Leadership Conference',
                      'Fri, 12/13',
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      ),
    );


  }
  Widget _buildAccessCard(BuildContext context, IconData icon, String title) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 120, // Fixed width for horizontal cards
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: colorScheme.primary),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildEventCard(
      BuildContext context, String imagePath, String title, String date) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(60),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 90,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'View All',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }



}
