import 'package:flutter/material.dart';
import 'package:ta_ppb/legendslist.dart';
import 'package:ta_ppb/api_service.dart';

class LegendsPage extends StatefulWidget {
  const LegendsPage({super.key});

  @override
  State<LegendsPage> createState() => _LegendsPageState();
}

class _LegendsPageState extends State<LegendsPage> {
  int currentPage = 1;
  final int itemsPerPage = 8;
  String searchQuery = "";

  Map<String, String> bioAkaCache = {};

  List<Map<String, String>> get filteredLegends {
    if (searchQuery.isEmpty) {
      return Legendslist.legends;
    }

    String normalizeString(String input) {
      return input.replaceAll(RegExp(r'[oóòôöøō]'), 'o');
    }

    return Legendslist.legends
        .where((legend) => normalizeString(legend["name"]!)
            .toLowerCase()
            .contains(normalizeString(searchQuery).toLowerCase()))
        .toList();
  }

  List<Map<String, String>> get paginatedLegends {
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage > filteredLegends.length)
        ? filteredLegends.length
        : start + itemsPerPage;
    return filteredLegends.sublist(start, end);
  }

  Future<void> fetchBioAka(String legendName) async {
    if (bioAkaCache.containsKey(legendName)) return;

    try {
      //Normalisasi nama API
      final normalizedName = legendName.toLowerCase().replaceAll(" ", "");
      final legendData = await ApiLegends.fetchLegendData(normalizedName);

      if (legendData != null && legendData['bio_aka'] != null) {
        setState(() {
          bioAkaCache[legendName] = legendData['bio_aka']!;
        });
      } else {
        setState(() {
          bioAkaCache[legendName] = "No bio available";
        });
      }
    } catch (e) {
      setState(() {
        bioAkaCache[legendName] = "Failed to load bio";
      });
    }
  }

  void showLegendPopup(BuildContext context, String legendName) async {
    try {
      //Normalisasi nama API 2
      final normalizedName = legendName.toLowerCase().replaceAll(" ", "");
      final data = await ApiLegends.fetchLegendData(normalizedName);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF001F3F),
            contentPadding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?["bio_name"] ?? "Unknown Legend",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    data?["bio_aka"] ?? "No AKA available",
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    "Weapon 1: ${data?["weapon_one"] ?? "Unknown"}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Weapon 2: ${data?["weapon_two"] ?? "Unknown"}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    data?["bio_text"] ?? "No additional information available.",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Failed to load legend details: $e",
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (filteredLegends.length / itemsPerPage).ceil();

    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        title: const Text(
          'Legends',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Column(
        children: [
          //Search Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF002B5B),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  currentPage = 1;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Type legend name here...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Daftar Agen
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: paginatedLegends.map((legend) {
                    final legendName = legend["name"]!;

                    fetchBioAka(legendName);

                    return GestureDetector(
                      onTap: () => showLegendPopup(context, legendName),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004080),
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.8),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  width: 80,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                      image: AssetImage(legend["image"]!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        legendName,
                                        style: const TextStyle(
                                          fontFamily: 'MonsalGothic',
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 3.0),
                                      Text(
                                        bioAkaCache[legendName] ??
                                            "Loading bio...",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
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
                  }).toList(),
                ),
              ),
            ),
          ),
          //Pagination
          if (searchQuery.isEmpty && filteredLegends.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  Text(
                    "Page $currentPage of $totalPages",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: currentPage < totalPages
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
