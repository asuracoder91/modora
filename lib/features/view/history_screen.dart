import 'package:flutter/material.dart';
import 'package:modora/core/core.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ModoraColors.mainColor,
              ModoraColors.mainBold,
            ], // Replace with desired colors
          ),
        ),
        child: const Center(
          child: Text(
            'History',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
