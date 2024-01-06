import 'package:flutter/material.dart';
import 'package:modora/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../authentications/models/custom_error.dart';
import '../../authentications/repos/auth_repository_provider.dart';
import '../../authentications/widgets/error_dialog.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ModoraColors.mainColor,
              ModoraColors.mainBold,
            ], // Replace with desired colors
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              try {
                await ref.read(authRepositoryProvider).signout();
              } on CustomError catch (e) {
                if (!context.mounted) return;
                errorDialog(context, e);
              }
            },
            behavior: HitTestBehavior.translucent,
            child: const Text(
              '로그아웃',
              style: TextStyle(color: ModoraColors.mainDarkest, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
