import 'package:flutter/material.dart';
import 'package:modora/core/core.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

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
            ], 
          ),
        ),
        child: const Center(
          child: Text(
            'Write',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
