import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Function() onPressed;

  final Widget icon;
  final String title;

  const ButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onTap: () {
          onPressed();
        },
        title: icon,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}