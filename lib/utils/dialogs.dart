import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, Widget pageBuilder, {required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) => pageBuilder,
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(
            parent: anim,
            curve: Curves.easeInOut
          ),
        ),
        child: child,
      );
    },
  ).then(onValue);
}
