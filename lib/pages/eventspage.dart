import 'package:flutter/material.dart';

class eventspage extends StatelessWidget {
  const eventspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F2F), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Events'),
        centerTitle: true,
        elevation: 0,
        leading: const BackButton(),
        actions: const [Icon(Icons.search)],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Featured'),
            FeaturedEventCard(),
            const SectionHeader(title: 'Upcoming events'),
            Column(
              children: [
                UpcomingEventCard(
                  title: 'Plan for retirement with ChatGPT',
                  speaker: 'ChatGPT',
                  time: 'Tue, Jan 3, 9:00 AM',
                  image: 'lib/assets/images/aiml.webp',
                ),
                UpcomingEventCard(
                  title: 'Introduction to Business Data Analytics',
                  speaker: 'Institute X',
                  time: 'Wed, Jan 4, 1:00 PM',
                  image: 'lib/assets/images/bulb.png',
                ),
                UpcomingEventCard(
                  title: 'Online - Scopus Publications',
                  speaker: 'Dr. Lee',
                  time: 'Thu, Jan 5, 12:00 PM',
                  image: 'lib/assets/images/book.png',
                ),
              ],
            ),
            const SectionHeader(title: 'Past events'),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PastEventCard(
                    title: 'AI in the future of work',
                    date: 'Dec 20, 2022',
                    image: 'lib/assets/images/aiml.webp',
                  ),
                  PastEventCard(
                    title: 'Introduction to Analytics',
                    date: 'Dec 21, 2022',
                    image: 'lib/assets/images/book.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FeaturedEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1F3D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset('lib/assets/images/featured_event.png')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Debate: The AGI debate',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 4),
                const Text('Fri, Dec 25, 2:00 PM',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 2),
                const Text('ISTE Manipal',
                    style: TextStyle(color: Colors.white38, fontSize: 13)),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Attend'),
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

class UpcomingEventCard extends StatelessWidget {
  final String title;
  final String speaker;
  final String time;
  final String image;

  const UpcomingEventCard({
    required this.title,
    required this.speaker,
    required this.time,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1F3D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text(speaker,
                      style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  Text(time,
                      style: const TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Register'),
            ),
          )
        ],
      ),
    );
  }
}

class PastEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String image;

  const PastEventCard({
    required this.title,
    required this.date,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, height: 90, width: 160, fit: BoxFit.cover)),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          Text(date,
              style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }
}
