import 'package:intl/intl.dart';
import 'package:libraria_news/data/models/post.dart';
import 'package:libraria_news/data/providers/provider.dart';
import 'package:libraria_news/data/repository/repository.dart';
import 'package:http/http.dart' as http;

class HomeController {
  PostRepository repository = PostRepository(provider: Provider(httpClient: http.Client()));

  Future<List<PostModel>> postList;
  String date;

  onInit() {
    postList = _fetchFuturePostList();
  }

  Future<List<PostModel>> _fetchFuturePostList() {
    return repository.getAllPosts();
  }

  nextPage() {
    return repository.getNextPage();
  }

  String dateFormat(String post) {
    var datePost = DateTime.parse(post);
    Duration duration = DateTime.now().difference(datePost);
    var date = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR').format(datePost);
    if (duration.inDays > 1) {
      return date;
    } else if (duration.inHours > 1) {
      return '${duration.inHours} horas atrás';
    } else if (duration.inHours == 1) {
      return '${duration.inHours} hora atrás';
    } else {
      return '${duration.inMinutes} minutos atrás';
    }
  }
}
