import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class SecondaryCourseCard extends StatelessWidget {

  final String icon;
  final String title;
  final Color color;

  const SecondaryCourseCard({
    super.key,
    required this.title,
    this.icon = "assets/icons/ios.svg",
    this.color = const Color(0xFF7553F6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Watch video - 15 mins",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(color: Colors.white70),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(icon)
        ],
      ),
    );
  }
}
