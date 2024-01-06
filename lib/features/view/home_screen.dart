import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modora/core/core.dart';
import 'package:modora/features/widgets/bottom_button.dart';

import '../../core/router/router_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('HomeScreen'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModoraColors.mainBold,
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationShell: navigationShell,
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation:
          const CustomEndDockedFloatingActionButtonLocation(),
    );
  }
}

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.navigationShell,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(selectedIndexProvider);
    return BottomAppBar(
      surfaceTintColor: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 0.3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BottomButton(
            iconName: "나의역사",
            isActive: currentIndex == 0,
            onPressed: () => _onTap(context, 0, ref),
          ),
          const Gap(20),
          BottomButton(
            iconName: "글보기",
            isActive: currentIndex == 1,
            onPressed: () => _onTap(context, 1, ref),
          ),
          const Gap(20),
          BottomButton(
            iconName: "달력보기",
            isActive: currentIndex == 2,
            onPressed: () => _onTap(context, 2, ref),
          ),
          const Gap(100),
          BottomButton(
            iconName: "정보",
            isActive: currentIndex == 4,
            onPressed: () => _onTap(context, 4, ref),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index, WidgetRef ref) {
    ref.read(selectedIndexProvider.notifier).state = index;
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        height: 68,
        width: 68,
        child: FloatingActionButton(
          backgroundColor: ModoraColors.mainDark,
          elevation: 0,
          shape: const CircleBorder(),
          child: const BottomButton(iconName: "기록", isActive: false),
          onPressed: () {},
        ),
      ),
    );
  }
}

/// FAB 위치를 임의로 조정하기 위한 클래스
class CustomEndDockedFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  const CustomEndDockedFloatingActionButtonLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    const double offset = -50;

    /// FAB의 위치 조정
    return FloatingActionButtonLocation.endDocked.getOffset(scaffoldGeometry) +
        const Offset(offset, 0);
  }
}
