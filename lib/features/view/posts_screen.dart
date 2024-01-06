import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Details'),
      ),
      body: Center(
        child: Text(
          'your id: $id',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
