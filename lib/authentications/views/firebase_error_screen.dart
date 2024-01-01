import 'package:flutter/material.dart';

/// 임시로 만든 에러 페이지. 새로 디자인할 것
class FirebaseErrorScreen extends StatelessWidget {
  const FirebaseErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Firebase Connection Error\n\nTry later!',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
