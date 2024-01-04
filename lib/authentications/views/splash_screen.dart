import 'package:flutter/material.dart';
import 'package:modora/core/constants/gaps.dart';
import 'package:modora/core/theme/modora_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ModoraColors.background,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset('assets/images/splash.png', height: size.height * 0.3),
            Gaps.v16,
            const Center(
              child: Text(
                "MODORA",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFcd517c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
