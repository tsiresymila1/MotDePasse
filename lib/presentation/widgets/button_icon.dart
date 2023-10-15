import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Function() onPressed;

  final Widget icon;
  final String title;
  final bool? disabled;

  const ButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: disabled == true
            ? null
            : () {
                onPressed();
              },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffFFA00B),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xffFFA00B).withOpacity(0.8),
                    blurStyle: BlurStyle.inner,
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(2, 4)),
                BoxShadow(
                    color: const Color(0xffFFA00B).withOpacity(0.6),
                    blurStyle: BlurStyle.inner,
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(2, 4))
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ));
  }
}
