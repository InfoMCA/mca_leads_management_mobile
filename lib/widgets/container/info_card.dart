import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget child;

  const InfoCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset.fromDirection(0),
            color: const Color(0x2F000000),
            blurRadius: 15,
          ),
        ],
      ),
      child: child,
    );
  }
}
