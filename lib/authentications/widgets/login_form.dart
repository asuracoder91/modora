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
    this.focusNode,
  });
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final FocusNode? focusNode;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _effectiveFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_handleFocusChange);

    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }

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
        focusNode: _effectiveFocusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        obscuringCharacter: '*',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(
            15,
            12,
            15,
            12,
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
