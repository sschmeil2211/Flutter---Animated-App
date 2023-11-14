import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {

  final RiveAnimationController _buttonAnimationController;
  final VoidCallback onTap;

  const AnimatedButton({
    super.key,
    required RiveAnimationController buttonAnimationController,
    required this.onTap,
  }) : _buttonAnimationController = buttonAnimationController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            RiveAnimation.asset("assets/RiveAssets/button.riv", controllers: [_buttonAnimationController]),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.arrow_right),
                  const SizedBox(width: 8),
                  Text("Start the course", style: Theme.of(context).textTheme.labelLarge)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
