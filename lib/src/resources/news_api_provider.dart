import 'dart:convert';
import '../models/item_model.dart';
import 'dart:async';
import 'repository.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider implements Source {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    final uri =
        Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json');
    try {
      final response = await client.get(uri);
      final body = jsonDecode(response.body) as List;
      return body.cast<int>();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final uri =
        Uri.parse('https://hacker-news.firebaseio.com/v0/item/$id.json');
    try {
      final response = await client.get(uri);
      final body = jsonDecode(response.body);
      final item = ItemModel.fromJson(body);
      return item;
    } catch (e) {
      return null;
    }
  }
}
