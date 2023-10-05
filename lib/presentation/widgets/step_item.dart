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
          border: isActive
              ? const Border.symmetric(
              horizontal: BorderSide.none,
              vertical: BorderSide(
                width: 10,
                color: Color(0xffFFD700),
              ))
              : const Border(),
          color: Colors.deepOrange),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Icon(Icons.monetization_on_rounded, color: Color(0xffFFD700),size: 16,)
        ],
      ),
    );
  }
}