import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/gaps.dart';
import '../../core/constants/sizes.dart';

class SocialLoginDark extends StatelessWidget {
  final String text;
  final SvgPicture icon;

  const SocialLoginDark({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(Sizes.size6),
          border: Border.all(
            color: Colors.black,
            width: Sizes.size1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Gaps.h10,
            Text(
              text,
              style: TextStyle(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
