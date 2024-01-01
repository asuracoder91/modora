import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modora/core/router/router_names.dart';

import '../../core/constants/gaps.dart';
import '../../core/constants/reg_expression.dart';
import '../../core/core.dart';
import '../widgets/auth_button.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login.dart';
import '../widgets/social_login_dark.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // form 관련 Key와 Controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hasValidEmail = false;
  bool _hasValidPassword = false;
  bool _isButtonActive = false;

  // email, password 저장하는 form
  Map<String, String> formData = {};

  void _goSignUpScreen(BuildContext context) {
    context.goNamed(RouteNames.signup);
  }

  // 버튼 상태 관리
  void _updateButtonState() {
    setState(() {
      _isButtonActive = _hasValidPassword && _hasValidEmail;
    });
  }

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _hasValidEmail = emailPattern.hasMatch(_emailController.text);
        _updateButtonState();
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _hasValidPassword = _passwordController.text.length >= 8;
        _updateButtonState();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("${screenSize.width}, ${screenSize.height}");
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
                              top: 43,
                              right: 30,
                              child: Image.asset(
                                "assets/images/login_papyrus.png",
                                height: screenSize.height > 700 ? 154 : 110,
                              ),
                            ),
                            Positioned(
                              top: screenSize.height > 700 ? 56 : 38,
                              left: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '로그인',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Gap(screenSize.height * 0.03),
                                  Text(
                                    '나만의 역사를 기록하기 위해\n로그인 해주세요',
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
                                text: "이메일",
                                controller: _emailController,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['email'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v8,
                              LoginForm(
                                text: "패스워드",
                                controller: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['password'] = newValue;
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
                            text: "로그인",
                            enabled: true,
                            //_isButtonActive && !ref.watch(loginProvider).isLoading,
                          ),
                        ),
                      ),
                      Gap(screenSize.height * 0.03),

                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "비밀번호를 잊으셨나요?",
                          style: TextStyle(
                            /// 로그인 폼 비밀번호 찾기 색상, 다크 테마 적용시 변경
                            color: ModoraColors.mainDark,
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
                        const Text('계정이 없으신가요? '),
                        GestureDetector(
                          onTap: () => _goSignUpScreen(context),
                          child: const Text(
                            '회원가입',
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
