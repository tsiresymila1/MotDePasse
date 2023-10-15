import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  final String title;
  final int index;
  final bool isActive;

  const StepItem({
    super.key,
    required this.title,
    required this.index,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isActive ? 12 : 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.deepOrange,
          boxShadow: [
            BoxShadow(
                color: isActive
                    ? const Color(0xd7FFD700)
                    : const Color(0xe5e85020),
                blurStyle: BlurStyle.inner,
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(-2, 4)),
            BoxShadow(
                color: isActive
                    ? const Color(0xd7FFD700)
                    : const Color(0xd7e85020),
                blurStyle: BlurStyle.inner,
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(-2, 4))
          ]),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Icon(
            Icons.monetization_on_rounded,
            color: Color(0xffFFD700),
            size: 16,
          )
        ],
      ),
    );
  }
}
