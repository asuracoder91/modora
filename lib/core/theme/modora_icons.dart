import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modora/core/core.dart';

abstract class ModoraIcons {
  static final SvgPicture calLight = SvgPicture.asset(
    'assets/icons/cal_light.svg',
  );
  static final SvgPicture cal = SvgPicture.asset(
    'assets/icons/cal.svg',
    colorFilter: const ColorFilter.mode(
      ModoraColors.mainDarker,
      BlendMode.srcIn,
    ),
  );
  static final SvgPicture docLight = SvgPicture.asset(
    'assets/icons/doc_light.svg',
  );
  static final SvgPicture doc = SvgPicture.asset(
    'assets/icons/doc.svg',
    colorFilter: const ColorFilter.mode(
      ModoraColors.mainDarker,
      BlendMode.srcIn,
    ),
  );
  static final SvgPicture paperLight = SvgPicture.asset(
    'assets/icons/Paper_light.svg',
  );
  static final SvgPicture paper = SvgPicture.asset(
    'assets/icons/Paper.svg',
    colorFilter: const ColorFilter.mode(
      ModoraColors.mainDarker,
      BlendMode.srcIn,
    ),
  );
  static final SvgPicture userLight = SvgPicture.asset(
    'assets/icons/user_light.svg',
  );
  static final SvgPicture user = SvgPicture.asset(
    'assets/icons/user.svg',
    colorFilter: const ColorFilter.mode(
      ModoraColors.mainDarker,
      BlendMode.srcIn,
    ),
  );
  static final SvgPicture editAlt = SvgPicture.asset(
    'assets/icons/Edit_alt.svg',
    colorFilter: const ColorFilter.mode(
      Colors.white,
      BlendMode.srcIn,
    ),
  );
}
