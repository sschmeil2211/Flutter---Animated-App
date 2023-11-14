import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'package:animated_app/models/models.dart';
import 'package:animated_app/utils/utils.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF17203A),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(name: "Sebastian", bio: "Developer"),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus.map((menu) => SideMenu(
                menu: menu,
                selectedMenu: selectedSideMenu,
                onTap: () {
                  RiveUtils.changeSMIBoolState(menu.rive.status!);
                  setState(() => selectedSideMenu = menu);
                },
                riveOnInit: (artBoard) => menu.rive.status = RiveUtils.getRiveInput(artBoard, stateMachineName: menu.rive.stateMachineName),
              )).toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2.map((menu) => SideMenu(
                menu: menu,
                selectedMenu: selectedSideMenu,
                onTap: () {
                  RiveUtils.changeSMIBoolState(menu.rive.status!);
                  setState(() => selectedSideMenu = menu);
                },
                riveOnInit: (artBoard) => menu.rive.status = RiveUtils.getRiveInput(artBoard, stateMachineName: menu.rive.stateMachineName),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {

  final Menu menu;
  final VoidCallback onTap;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedMenu;

  const SideMenu({
    super.key,
    required this.menu,
    required this.onTap,
    required this.riveOnInit,
    required this.selectedMenu
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: onTap,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu.rive.src,
                  artboard: menu.rive.artBoard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {

  final String name;
  final String bio;

  const InfoCard({
    super.key,
    required this.name,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person, color: Colors.white),
      ),
      title: Text(name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(bio, style: const TextStyle(color: Colors.white70)),
    );
  }
}
