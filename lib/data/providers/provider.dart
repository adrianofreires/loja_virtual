import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:libraria_news/data/models/post.dart';
import 'package:meta/meta.dart';

final String _baseUrl = 'https://news.libraria.com.br/wp-json/wp/v2/posts?page=';
int _page = 1;

int get page => _page;
set page(int value) => _page = value;
List<PostModel> postList = [];

class Provider {
  final http.Client httpClient;
  Provider({@required this.httpClient});

  Future<List<PostModel>> getAllPosts() async {
    try {
      var response = await http.get(_baseUrl + page.toString());
      List jsonResponse = json.decode(response.body);
      jsonResponse.forEach((json) {
        postList.add(PostModel.fromJson(json));
        print(_baseUrl + page.toString());
      });
    } catch (e) {
      print('Algo deu errado: Post Provider');
      return null;
    }

    return postList;
  }

  Future<List<PostModel>> getNextPage() async {
    page++;
    return getAllPosts();
  }
}
