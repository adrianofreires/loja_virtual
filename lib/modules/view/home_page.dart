import 'package:flutter/material.dart';
import 'components/post_list_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: PostList(),
    );
  }
}
