import 'dart:math';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'package:animated_app/utils/utils.dart';
import 'package:animated_app/models/models.dart';
import 'package:animated_app/views/screens/screens.dart';
import 'package:animated_app/views/widgets/widgets.dart';

class InitialRoute extends StatefulWidget {
  const InitialRoute({super.key});

  @override
  State<InitialRoute> createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> with SingleTickerProviderStateMixin {

  bool isSideBarOpen = false;
  Menu selectedBottomNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> animation;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottomNav != menu)
      setState(() => selectedBottomNav = menu);
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() => setState(() {}));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor2,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288,
            top: 0,
            child: const SideBar(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(1 * animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: HomePage(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 220 : 0,
            top: 16,
            child: MenuButton(
              onTap: () {
                isMenuOpenInput.value = !isMenuOpenInput.value;
                _animationController.value == 0 ? _animationController.forward() : _animationController.reverse();
                setState(() => isSideBarOpen = !isSideBarOpen);
              },
              riveOnInit: (artBoard) {
                final controller = StateMachineController.fromArtboard(artBoard, "State Machine");
                artBoard.addController(controller!);
                isMenuOpenInput = controller.findInput<bool>("isOpen") as SMIBool;
                isMenuOpenInput.value = true;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor2.withOpacity(0.3),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavItems.length,
                  (index) {
                    Menu navBar = bottomNavItems[index];
                    return BottomNavItem(
                      navBar: navBar,
                      onTap: () {
                        RiveUtils.changeSMIBoolState(navBar.rive.status!);
                        updateSelectedBtmNav(navBar);
                      },
                      riveOnInit: (artBoard) => navBar.rive.status = RiveUtils.getRiveInput(artBoard, stateMachineName: navBar.rive.stateMachineName),
                      selectedNav: selectedBottomNav,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
