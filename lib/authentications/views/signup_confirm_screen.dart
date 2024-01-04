import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/gaps.dart';
import '../../core/core.dart';
import '../../core/router/router_names.dart';
import '../models/custom_error.dart';
import '../view_models/signup_provider.dart';
import '../widgets/auth_button.dart';
import '../widgets/error_dialog.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login.dart';
import '../widgets/social_login_dark.dart';

class SignUpConfirmScreen extends ConsumerStatefulWidget {
  const SignUpConfirmScreen({
    super.key,
  });

  @override
  ConsumerState<SignUpConfirmScreen> createState() =>
      _SignUpConfirmScreenState();
}

class _SignUpConfirmScreenState extends ConsumerState<SignUpConfirmScreen> {
  // form 관련 Key와 Controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  String clientErrorMessage = "";
  bool _hasValidPassword = false;
  bool _hasValidPasswordCheck = false;
  bool _isButtonActive = false;

  // Form 값을 저장하는 Map
  Map<String, String> formData = {};

  void _goLoginScreen(BuildContext context) {
    context.goNamed(RouteNames.login);
  }

  // 버튼 상태 관리
  void _updateButtonState() {
    setState(() {
      _isButtonActive = _hasValidPassword && _hasValidPasswordCheck;
    });
  }

  /// 폼 제출
  void _submit({required String nickname, required String email}) {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref.read(signupProvider.notifier).signup(
          nickname: nickname,
          email: email,
          password: _passwordController.text.trim(),
        );
  }

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        clientErrorMessage = "";
        _hasValidPassword = _passwordController.text.length >= 8;
        if (!_hasValidPassword) {
          clientErrorMessage = "패스워드를 8글자 이상 입력해주세요";
        }
        if (_hasValidPassword ||
            _passwordController.text.isEmpty ||
            _passwordController.text == "") {
          clientErrorMessage = "";
        }
        _updateButtonState();
      });
    });
    _passwordCheckController.addListener(() {
      setState(() {
        clientErrorMessage = "";
        _hasValidPasswordCheck = _passwordCheckController.text.trim() ==
            _passwordController.text.trim();
        if (!_hasValidPasswordCheck) {
          clientErrorMessage = "패스워드가 일치하지 않습니다";
        }
        if (_hasValidPasswordCheck ||
            _passwordCheckController.text.isEmpty ||
            _passwordCheckController.text == "") {
          clientErrorMessage = "";
        }

        _updateButtonState();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final paddingSize = screenSize.width >= 400 ? 30.0 : 25.0;
    // error message handling provider monitor
    final errorMessage = ref.watch(signUpErrorMessageProvider);
    final formData = ref.watch(formDataProvider);
    final nickname = formData['nickname'] ?? '';
    final email = formData['email'] ?? '';
    ref.listen<AsyncValue<void>>(
      signupProvider,
      (previous, next) {
        next.whenOrNull(
          error: (e, st) => errorDialog(
            context,
            (e as CustomError),
          ),
        );
      },
    );

    final signupState = ref.watch(signupProvider);

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
                      if (screenSize.height > 860)
                        const SizedBox(
                          height: 16,
                        ),
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
                        padding: EdgeInsets.symmetric(horizontal: paddingSize),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginForm(
                                text: "패스워드 (8자리 이상)",
                                controller: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    formData['password'] = newValue;
                                  }
                                },
                              ),
                              Gaps.v8,
                              LoginForm(
                                text: "패스워드 확인",
                                controller: _passwordCheckController,
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
                                visible: (errorMessage != null &&
                                        errorMessage.isNotEmpty) ||
                                    (clientErrorMessage.isNotEmpty &&
                                        clientErrorMessage != ""),
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: SizedBox(
                                  height: 40,
                                  child: Text(
                                    errorMessage ?? clientErrorMessage,
                                    style: const TextStyle(
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
                        padding: EdgeInsets.symmetric(horizontal: paddingSize),
                        child: GestureDetector(
                          onTap: () =>
                              _submit(nickname: nickname, email: email),
                          child: AuthButton(
                            text: "회원가입",
                            enabled: _isButtonActive &&
                                !ref.watch(signupProvider).isLoading,
                          ),
                        ),
                      ),
                      Gap(screenSize.height * 0.03),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "뒤로 돌아가기",
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '이미 계정이 있으시면? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _goLoginScreen(context),
                          child: const Text(
                            '로그인',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: ModoraColors.mainDarker,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 로딩 중이면 로딩 표시
              // || ref.watch(googleLoginProvider).isLoading 추가
              if (ref.watch(signupProvider).isLoading) ...[
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
