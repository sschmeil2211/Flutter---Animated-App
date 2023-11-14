import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'package:animated_app/models/models.dart';

class BottomNavItem extends StatelessWidget {

  final Menu navBar;
  final VoidCallback onTap;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedNav;

  const BottomNavItem({
    super.key,
    required this.navBar,
    required this.onTap,
    required this.riveOnInit,
    required this.selectedNav
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: RiveAnimation.asset(
                navBar.rive.src,
                artboard: navBar.rive.artBoard,
                onInit: riveOnInit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {

  final bool isActive;

  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFF81B4FF),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
