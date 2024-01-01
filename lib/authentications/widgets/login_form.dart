import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modora/core/core.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.text,
    required this.obscureText,
    required this.controller,
    required this.onSaved,
    required this.keyboardType,
  });
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _isFocused

              /// 로그인 폼 포커스 보더 색상, 다크 테마 적용시 변경
              ? ModoraColors.greenBold
              : Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        obscuringCharacter: '*',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(
            15,
            10,
            15,
            10,
          ),
          filled: true,

          /// 로그인 폼 배경색, 다크 테마 적용시 변경
          fillColor: ModoraColors.grayLight,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelText: widget.text,
          labelStyle: const TextStyle(
            /// 로그인 폼 라벨 색상, 다크 테마 적용시 변경
            color: ModoraColors.greenDarker,
            fontSize: 16,
            letterSpacing: -0.3,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: const TextStyle(
            /// 로그인 폼 라벨 색상, 다크 테마 적용시 변경
            color: ModoraColors.greenDarker,
            height: 1.3,
            fontSize: 16,
          ),
        ),
        onSaved: widget.onSaved,
      ),
    );
  }
}
