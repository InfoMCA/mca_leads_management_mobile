import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationSvgIcon extends StatelessWidget {
  final String asset;
  final bool isActive;

  const CustomNavigationSvgIcon({required this.asset, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: isActive ? const Color(0xFF014F8B) : const Color(0xFFF3F3F3),
      ),
      child: SvgPicture.asset(
        asset,
        color: isActive ? Colors.white : null,
      ),
    );
  }
}