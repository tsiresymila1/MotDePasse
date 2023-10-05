import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final Function(bool e)? onChanged;
  final bool initialState;

  const SwitchWidget({Key? key, this.onChanged, required this.initialState})
      : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchWidget> {
  bool state = false;

  @override
  void initState() {
    state = widget.initialState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: state,
        onChanged: (e) {
          if (widget.onChanged != null) {
            widget.onChanged!(e);
            setState(() {
              state = e;
            });
          }
        });
  }
}
