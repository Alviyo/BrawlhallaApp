import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ta_ppb/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiGithub _apiService = ApiGithub();
  final ApiBrawlhalla _brawlhallaService = ApiBrawlhalla();
  Map<String, dynamic>? githubProfile;
  Map<String, dynamic>? brawlhallaRank;
  bool isLoadingRank = false;

  @override
  void initState() {
    super.initState();
    _loadGitHubProfile();
    _loadBrawlhallaRank();
  }

  final List<Map<String, String>> photosDetails = [
    {
      'name': 'Alvian',
      'image': 'assets/pp1.jpg',
      'rank': 'Platinum 1',
      'peakElo': '1776',
      'gamesPlayed': '156',
      'wins': '78',
    },
    {
      'name': 'Ghazi',
      'image': 'assets/gaji.jpg',
      'rank': 'Platinum 1',
      'peakElo': '1742',
      'gamesPlayed': '592',
      'wins': '297',
    },
    {
      'name': 'Syafiq',
      'image': 'assets/syafiq.jpg',
      'rank': 'Gold 1',
      'peakElo': '1551',
      'gamesPlayed': '282',
      'wins': '150',
    },
    {
      'name': 'Gary',
      'image': 'assets/gary.jpg',
      'rank': 'Gold 4',
      'peakElo': '1628',
      'gamesPlayed': '463',
      'wins': '40',
    },
  ];

  Future<void> _loadBrawlhallaRank() async {
    setState(() {
      isLoadingRank = true;
    });
    try {
      final rankData = await _brawlhallaService.fetchRankedData(
          'https://steamcommunity.com/profiles/76561198350866134/');
      setState(() {
        brawlhallaRank = rankData;
        isLoadingRank = false;
      });
    } catch (e) {
      setState(() {
        brawlhallaRank = {'error': 'Failed to load Brawlhalla rank'};
        isLoadingRank = false;
      });
    }
  }

  Future<void> _loadGitHubProfile() async {
    try {
      final profile = await _apiService.fetchGitHubProfile('Alviyo');
      setState(() {
        githubProfile = profile;
      });
    } catch (e) {
      setState(() {
        githubProfile = {'error': 'Failed to load GitHub profile'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> photos = [
      'assets/pp1.jpg',
      'assets/pp.png',
      'assets/pp3.jpg',
      'assets/pp4.jpg',
    ];

    final List<Map<String, String>> logos = [
      {
        'image': 'assets/dc.png',
        'url': 'https://discordapp.com/users/364733009728897024',
      },
      {
        'image': 'assets/insta.png',
        'url': 'https://www.instagram.com/vianlah_/',
      },
      {
        'image': 'assets/wa.png',
        'url': 'https://wa.me/6285159592558',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Author',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'MonsalGothic',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -60,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/pp.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            const Text(
              'Alvian Widiyanto',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'MonsalGothic',
              ),
            ),
            Text(
              'alvianwidiyantoo@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showBrawlhallaRankPopup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Brawlhalla Rank',
                style: TextStyle(fontSize: 16, fontFamily: 'MonsalGothic'),
              ),
            ),
            const SizedBox(height: 30),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: 'Players'),
                      Tab(text: 'About Me'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        kBottomNavigationBarHeight -
                        470,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 9,
                                mainAxisSpacing: 9,
                                childAspectRatio: 1.6,
                              ),
                              itemCount: photos.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _showPhotoPopup(
                                        context, photosDetails[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            photosDetails[index]['image']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //GitHub di about me
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        if (githubProfile == null)
                                          const CircularProgressIndicator()
                                        else if (githubProfile!
                                            .containsKey('error'))
                                          Text(githubProfile!['error'])
                                        else ...[
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              githubProfile!['avatar_url'],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            githubProfile!['name'] ??
                                                'GitHub Name Not Available',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final url =
                                                  githubProfile!['html_url'];
                                              if (await canLaunchUrl(
                                                  Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              }
                                            },
                                            child: Text(
                                              githubProfile!['html_url'],
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  //Teks Perkenalan
                                  const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Perkenalkan saya Alvian Widiyanto biasa dipanggil dengan Alvian, Vian, ataupun Yanto. Saya merupakan Mahasiswa dari Teknik Komputer Universitas Diponegoro angkatan ke 2022. Saya Lahir di Bantul pada tanggal 11 bulan Juli tahun 2003.',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontFamily: "MonsalGothic",
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: logos.map((logo) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final url = logo['url']!;
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      }
                                    },
                                    child: Image.asset(
                                      logo['image']!,
                                      width: 70,
                                      height: 40,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBrawlhallaRankPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: isLoadingRank
                ? const Center(child: CircularProgressIndicator())
                : (brawlhallaRank == null ||
                        brawlhallaRank!.containsKey('error'))
                    ? const Center(
                        child: Text(
                          'Failed to load rank data',
                          style: TextStyle(fontFamily: 'MonsalGothic'),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            brawlhallaRank!['name'] ?? 'Unknown Player',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/${_getImageName(brawlhallaRank!['tier'])}.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Rank: ${brawlhallaRank!['tier']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Elo: ${brawlhallaRank!['rating']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Peak Elo: ${brawlhallaRank!['peak_rating']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Games Played: ${brawlhallaRank!['games']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Wins: ${brawlhallaRank!['wins']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'MonsalGothic',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                            ),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'MonsalGothic',
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }

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
}

void _showPhotoPopup(BuildContext context, Map<String, String> photoDetail) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                photoDetail['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MonsalGothic',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Image.asset(
                photoDetail['image']!,
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Rank: ${photoDetail['rank']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'MonsalGothic',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Peak Elo: ${photoDetail['peakElo']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'MonsalGothic',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Games Played: ${photoDetail['gamesPlayed']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'MonsalGothic',
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Wins: ${photoDetail['wins']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'MonsalGothic',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'MonsalGothic',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
