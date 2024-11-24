import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              //Judul & Logo
              Center(
                child: Image.asset(
                  'assets/BrawlhallaLogo.png',
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Brawlhalla",
                  style: TextStyle(
                    fontFamily: 'MonsalGothic',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              //Garis
              Center(
                child: Container(
                  height: 4,
                  width: 345,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //Teks Awal
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Brawlhalla is an epic platform fighter for up to 8 players online or local. "
                  "Try casual free-for-alls, ranked matches, or invite friends to a private room. "
                  "And it's free! Play cross-platform with millions of players on PlayStation, Xbox, Nintendo Switch, iOS, Android & Steam! "
                  "Frequent updates. Over sixty Legends.",
                  style: TextStyle(
                    fontFamily: 'MonsalGothic',
                    fontSize: 16,
                    color: Color.fromARGB(255, 153, 153, 153),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Minimum Requirements:",
                  style: TextStyle(
                    fontFamily: 'MonsalGothic',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "- Operating System: iOS, Android, Windows, PS, Xbox, Nintendo Switch\n"
                  "- Minimum RAM: 2GB\n"
                  "- Minimum Storage: 1GB\n"
                  "- Internet Connection for online play",
                  style: TextStyle(
                    fontFamily: 'MonsalGothic',
                    fontSize: 16,
                    color: Color.fromARGB(255, 102, 102, 102),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
