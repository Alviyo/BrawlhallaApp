import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBrawlhalla {
  Future<Map<String, dynamic>> fetchRankedData(String steamUrl) async {
    final apiUrl =
        "https://brawlhalla.fly.dev/v1/ranked/steamurl?steam_url=$steamUrl";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']; // Menyediakan hanya data yang relevan
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class ApiLegends {
  static const String _baseUrl = "https://brawlhalla.fly.dev/v1";

  static Future<Map<String, dynamic>?> fetchLegendData(
      String legendName) async {
    final url = Uri.parse("$_baseUrl/legends/name?legend_name=$legendName");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class ApiGithub {
  final String baseUrl = "https://api.github.com/users/";

  Future<Map<String, dynamic>> fetchGitHubProfile(String username) async {
    final url = Uri.parse('$baseUrl$username');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load GitHub profile');
    }
  }
}
