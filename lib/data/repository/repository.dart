import 'package:libraria_news/data/models/post.dart';
import 'package:libraria_news/data/providers/provider.dart';
import 'package:meta/meta.dart';

class PostRepository {
  final Provider provider;

  PostRepository({@required this.provider}) : assert(provider != null);

  Future<List<PostModel>> getAllPosts() => provider.getAllPosts();

  Future<List<PostModel>> getNextPage() => provider.getNextPage();
}
