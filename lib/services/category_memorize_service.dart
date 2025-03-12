import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryMemorizeService {
  Future<List<String>> fetchCategories() async {
    final String accessToken = dotenv.get('access_token');

    final url = _getUrl();
    final target = Uri.parse(url);

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Notion-Version': '2021-05-13',
    };
    final response = await http.get(
      target,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results =
          data['properties']['分類']['select']['options'];
      if (results.isNotEmpty) {
        return results.map<String>((result) => result['name']).toList();
      }
    }
    return [];
  }

  String _getUrl() {
    String databaseId = dotenv.get('database_id');
    return 'https://api.notion.com/v1/databases/$databaseId';
  }
}
