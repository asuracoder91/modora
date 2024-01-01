import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/gaps.dart';
import '../../core/constants/reg_expression.dart';
import '../../core/core.dart';
import '../../core/router/router_names.dart';
import '../widgets/auth_button.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login.dart';
import '../widgets/social_login_dark.dart';
import 'signup_confirm_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // form 관련 Key와 Controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _hasValidEmail = false;
  bool _hasValidPassword = false;
  bool _isButtonActive = false;

  // Form 값을 저장하는 Map
  Map<String, String> formData = {};

  void _goLoginScreen(BuildContext context) {
    context.goNamed(RouteNames.login);
  }

  /// TODO: 중복 아이디 체크 기능 구현 필요
  void _onNextTap() {
    if (formData.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpConfirmScreen(
          nickname: formData['nickname'] ?? '',
          email: formData['email'] ?? '',
        ),
      ),
    );
  }

  // 버튼 상태 관리
  void _updateButtonState() {
    setState(() {
      _isButtonActive = _hasValidPassword && _hasValidEmail;
    });
  }

  @override
  void initState() {
    _nickNameController.addListener(() {
      setState(() {
        _hasValidPassword = _nickNameController.text.isNotEmpty;
        _updateButtonState();
      });
    });
    _emailController.addListener(() {
      setState(() {
        _hasValidEmail = emailPattern.hasMatch(_emailController.text);
        _updateButtonState();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // error message handling provider monitor
    // final errorMessage = ref.watch(errorMessageProvider);
    const errorMessage = null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 화면 터치하면 키보드 내려감
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 가상 키보드 올라왔을 때 화면깨짐 방지
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 상단 블럭
                  Column(
                    children: [
                      SizedBox(
                        height: screenSize.height > 700 ? 200 : 150,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 4,
                              child: Image.asset(
                                "assets/images/signup.png",
                                height: screenSize.height > 700 ? 220 : 160,
                              ),
                            ),
                            Positioned(
                              top: screenSize.height > 700 ? 56 : 38,
                              left: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '회원가입',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Gap(screenSize.height * 0.03),
                                  Text(
                                    '회원가입 후 다양한 기기로\n이용할 수 있습니다',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginForm(
                                text: "별명 (자유롭게 변경 가능)",
                                controller: _nickNameController,
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['nickname'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v8,
                              LoginForm(
                                text: "이메일 주소",
                                controller: _emailController,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['email'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v6,
                              Visibility(
                                visible: errorMessage != null &&
                                    errorMessage.isNotEmpty,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: const SizedBox(
                                  height: 40,
                                  child: Text(
                                    errorMessage ?? "",
                                    style: TextStyle(
                                      color:

                                          /// 로그인 폼 에러 메시지 색상, 다크 테마 적용시 변경
                                          ModoraColors.mainDarker,
                                      fontSize: 16,
                                      letterSpacing: -0.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: const AuthButton(
                            text: "다음",
                            enabled: true,
                            //_isButtonActive && !ref.watch(loginProvider).isLoading,
                          ),
                        ),
                      ),
                      Gap(screenSize.height * 0.03),

                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "뒤로 돌아가기",
                          style: TextStyle(
                            /// 로그인 폼 비밀번호 찾기 색상, 다크 테마 적용시 변경
                            color: Colors.transparent,
                            fontSize: 16,
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      screenSize.height > 700
                          ? Gap(screenSize.height * 0.07)
                          : Gap(screenSize.height * 0.04),

                      /// 구글 로그인 버튼
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: SocialLogin(
                          text: "Sign In with Google",
                          icon: SvgPicture.asset(
                            "assets/icons/icons8-google.svg",
                            width: 28,
                          ),
                        ),
                      ),
                      Gaps.v10,

                      /// 애플 로그인 버튼
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: SocialLoginDark(
                          text: "Continue with Apple",
                          icon: SvgPicture.asset(
                            "assets/icons/icons8-apple-logo.svg",
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //최하단 텍스트 : 회원가입
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('이미 계정이 있으시면? '),
                        GestureDetector(
                          onTap: () => _goLoginScreen(context),
                          child: const Text(
                            '로그인',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ModoraColors.mainDarker,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 로딩 중이면 로딩 표시
              // if (ref.watch(loginProvider).isLoading ||
              //     ref.watch(googleLoginProvider).isLoading) ...[
              //   const Center(
              //     child: CircularProgressIndicator.adaptive(),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
