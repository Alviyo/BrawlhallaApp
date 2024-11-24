import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui';
import 'package:ta_ppb/animated_cart.dart';
import 'yourstat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'legends.dart';
import 'about.dart';

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 7, 28, 53),
                  Color.fromARGB(255, 7, 28, 53),
                  Color.fromARGB(255, 10, 43, 114),
                  Color.fromARGB(255, 10, 43, 114),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                  Colors.white,
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              //SliverAppBar Video & Logo
              SliverAppBar(
                expandedHeight: 190.0, //Tinggi
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      //Video
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const VideoPlayerWidget(),
                      ),
                      //Logo
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            //Shadow, blur logo
                            Container(
                              height: 135,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                    sigmaX: 10, sigmaY: 10), //Efek blur
                                child: Opacity(
                                  opacity: 0.65,
                                  child: Image.asset(
                                    'assets/BrawlhallaLogo.png',
                                    color: Colors.black,
                                    colorBlendMode: BlendMode.srcATop,
                                  ),
                                ),
                              ),
                            ),
                            // Gambar logo
                            Image.asset(
                              'assets/BrawlhallaLogo.png',
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16), //jarak dari video
                      const Text(
                        "Welcome to Brawlhalla",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MonsalGothic',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Brawlhalla is a free 2D platform fighting game that supports up to 8 local or online players with full cross-play for PC, PS5, PS4, Xbox Series X|S, Xbox One, Nintendo Switch, iOS and Android! History's greatest warriors brawl to prove who's the best in an epic test of strength and skill.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'MonsalGothic',
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 30,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          CustomWidgetCard(
                            title: 'About',
                            imagePath: 'assets/about.jpg',
                            fontSize: 36,
                            alignment: Alignment.bottomCenter,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutPage()),
                              );
                            },
                          ),
                          CustomWidgetCard(
                            title: 'Legends',
                            imagePath: 'assets/agents.jpg',
                            fontSize: 36,
                            alignment: Alignment.bottomCenter,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LegendsPage()),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedCard(
                          title: 'See Your Stat Here',
                          imagePath: 'assets/stat.jpg',
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 150,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const YourStatPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 250),
                      //Bagian bawah home page
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo Brawlhalla
                              Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/BrawlhallaLogo.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      30), //Jarak logo Brawlhalla dan logo-logo kanan

                              //Logo Sosmed
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //Logo baris atas
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://discord.com/invite/brawlhalla');
                                          },
                                          child: Image.asset(
                                              'assets/discord.png',
                                              height: 37),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://www.instagram.com/brawlhalla');
                                          },
                                          child: Image.asset('assets/ig.png',
                                              height: 45),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://www.facebook.com/Brawlhalla/');
                                          },
                                          child: Image.asset('assets/fb.png',
                                              height: 40),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://www.tiktok.com/@brawlhalla');
                                          },
                                          child: Image.asset(
                                              'assets/tiktok.png',
                                              height: 35),
                                        ),
                                      ],
                                    ),
                                    //Logo baris Bawah
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://x.com/brawlhalla');
                                          },
                                          child: Image.asset(
                                            'assets/twit.png',
                                            height: 33,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://www.twitch.tv/brawlhalla');
                                          },
                                          child: Image.asset(
                                              'assets/twitch.png',
                                              height: 45),
                                        ),
                                        const SizedBox(
                                            width: 5), // Jarak antar logo
                                        GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'https://www.youtube.com/c/brawlhalla');
                                          },
                                          child: Image.asset(
                                              'assets/youtube.png',
                                              height: 35),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 20), //Jarak logo dan bagian bawah

                          //Baris untuk logo tambahan dan teks
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Logo Ubisoft dan Blue Mammoth
                              Row(
                                children: [
                                  //Logo Ubisoft
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/ubisoftLogo.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          9), //Jarak logo Ubisoft dan Blue Mammoth
                                  //Logo Blue Mammoth
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/BlueMammoth.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Teks "Made by..." paling bawah
                              const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 6),
                                  Text(
                                    "Made By Alvian Widiyanto Tekkom 2022.",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Widget video
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/demo.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}

//Widget kustom untuk card biasa
class CustomWidgetCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double fontSize;
  final Alignment alignment;
  final VoidCallback? onTap;

  const CustomWidgetCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.fontSize = 36,
    this.alignment = Alignment.bottomCenter,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Align(
          alignment: alignment,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'MonsalGothic',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(4.0, 4.0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

//Widget kustom khusus "See Your Stat Here"
class SeeYourStatCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  final double height;
  final double fontSize;
  final double shadowBlurRadius;
  final Color shadowColor;
  final Offset shadowOffset;

  const SeeYourStatCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.width = double.infinity,
    this.height = 300,
    this.shadowBlurRadius = 5.0,
    this.fontSize = 36,
    this.shadowOffset = const Offset(2.0, 2.0),
    this.shadowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0], //Posisi gradasi
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'MonsalGothic',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: shadowBlurRadius,
                  color: shadowColor,
                  offset: shadowOffset,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
