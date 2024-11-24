import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ta_ppb/api_service.dart';

class YourStatPage extends StatefulWidget {
  const YourStatPage({super.key});

  @override
  State<YourStatPage> createState() => _YourStatPageState();
}

class _YourStatPageState extends State<YourStatPage> {
  final TextEditingController _controller = TextEditingController();
  final ApiBrawlhalla _apiService = ApiBrawlhalla();
  Future<Map<String, dynamic>>? _apiResponse;
  bool _hasSearched = false;

  String _getImageName(String tier) {
    String rank = tier.split(' ')[0];
    switch (rank) {
      case 'Tin':
        return 'Tin';
      case 'Bronze':
        return 'Bronze';
      case 'Silver':
        return 'Silver';
      case 'Gold':
        return 'Gold';
      case 'Platinum':
        return 'Platinum';
      case 'Diamond':
        return 'Diamond';
      case 'Valhallan':
        return 'Valhallan';
      default:
        return 'default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Stat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          //Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          //Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!_hasSearched)
                      Image.asset(
                        'assets/gambarstat.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText:
                              'https://steamcommunity.com/profiles/123xxxxxxxxx/',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontFamily: 'MonsalGothic'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          suffixIcon: const Icon(Icons.search,
                              color: Colors.blueAccent),
                        ),
                        onTap: () {
                          if (_controller.text ==
                              'https://steamcommunity.com/profiles/123xxxxxxxxx/') {
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _apiResponse = _apiService
                              .fetchRankedData(_controller.text.trim());
                          _hasSearched = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: Colors.orange.withOpacity(0.5),
                        elevation: 5.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 15.0),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          fontFamily: 'MonsalGothic',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_hasSearched)
                      FutureBuilder<Map<String, dynamic>>(
                        future: _apiResponse,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'MonsalGothic'),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Column(
                              children: [
                                //Nampilin Gambar sesuai data
                                Image.asset(
                                  'assets/${_getImageName(data['tier'])}.png',
                                  width: 150.0,
                                  height: 150.0,
                                ),
                                //Nampilin Data statistik
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildStatBox('Name',
                                          '${data['name']} | ${data['brawlhalla_id']}',
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 240, 191, 32),
                                            const Color.fromARGB(
                                                255, 255, 220, 106),
                                            const Color.fromARGB(
                                                255, 240, 191, 32)
                                          ]),
                                      _buildStatBox('Rank', data['tier'],
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                            const Color.fromARGB(
                                                255, 255, 255, 255),
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                          ]),
                                      _buildStatBox(
                                          'Elo', data['rating'].toString(),
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                            const Color.fromARGB(
                                                255, 255, 255, 255),
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                          ]),
                                      _buildStatBox('Peak Elo',
                                          data['peak_rating'].toString(),
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                            const Color.fromARGB(
                                                255, 255, 255, 255),
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                          ]),
                                      _buildStatBox(
                                          'Games', data['games'].toString(),
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                            const Color.fromARGB(
                                                255, 255, 255, 255),
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                          ]),
                                      _buildStatBox(
                                          'Wins', data['wins'].toString(),
                                          gradientColors: [
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                            const Color.fromARGB(
                                                255, 255, 255, 255),
                                            const Color.fromARGB(
                                                255, 208, 232, 255),
                                          ]),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(child: Text('No data found.'));
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value,
      {required List<Color> gradientColors}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$label :',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'MonsalGothic',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style:
                    const TextStyle(fontSize: 18.0, fontFamily: 'MonsalGothic'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
