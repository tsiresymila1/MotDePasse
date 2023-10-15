import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final Function(int e)? onChanged;
  final int initialState;

  const Counter({Key? key, this.onChanged, required this.initialState})
      : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int value = 1;

  @override
  void initState() {
    value = widget.initialState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CartStepperInt(
      value: value,
      size: 40,
      numberSize: 2,
      style: const CartStepperStyle().copyWith(
          activeBackgroundColor: Colors.deepOrange.withOpacity(0.5),
          textStyle: const TextStyle(color: Colors.white, fontSize: 32)),
      didChangeCount: (int val) {
        setState(() {
          value = val;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
    );
  }
}
