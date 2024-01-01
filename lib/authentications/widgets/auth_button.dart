import 'package:flutter/material.dart';

import '../../core/core.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.enabled,
  });
  final String text;
  final bool enabled;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.enabled
            ?

            /// 로그인 버튼 색상, 다크 테마 적용시 변경
            ModoraColors.mainDark
            : ModoraColors.gray,
      ),
      child: Center(
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
