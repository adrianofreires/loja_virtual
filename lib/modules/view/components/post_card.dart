import 'package:flutter/material.dart';
import 'package:libraria_news/data/models/post.dart';
import 'package:libraria_news/modules/controller/home_controller.dart';
import 'package:libraria_news/modules/view/components/article.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  final HomeController controller = HomeController();

  PostCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.black,
      child: GestureDetector(
        excludeFromSemantics: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Article(
                  url: post.link_url,
                  category: post.categories.first,
                );
              });
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
              child: Image.network(post.featuredMedia),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        post.categories.first,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Text(
                        controller.dateFormat(post.date),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    post.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
