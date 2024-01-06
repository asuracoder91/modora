import 'package:flutter/material.dart';
import 'package:modora/core/constants/gaps.dart';

import '../../core/core.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.iconName,
    required this.isActive,
    this.onPressed,
  });

  final String iconName;
  final bool isActive;
  final VoidCallback? onPressed; // 콜백 타입 정의

  Widget _buildIcon() {
    switch (iconName) {
      case '달력보기':
        return isActive ? ModoraIcons.cal : ModoraIcons.calLight;
      case '글보기':
        return isActive ? ModoraIcons.doc : ModoraIcons.docLight;
      case '나의역사':
        return isActive ? ModoraIcons.paper : ModoraIcons.paperLight;
      case '정보':
        return isActive ? ModoraIcons.user : ModoraIcons.userLight;
      case '기록':
        return ModoraIcons.editAlt;
      default:
        return ModoraIcons.paperLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildIcon(),
            Gaps.v3,
            Text(
              iconName,
              style: isActive
                  ? ModoraTextStyles.bottomBarActive
                  : iconName == "기록"
                      ? ModoraTextStyles.bottomBarInactiveWhite
                      : ModoraTextStyles.bottomBarInactive,
            ),
          ],
        ),
      ),
    );
  }
}
