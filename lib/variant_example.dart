import 'package:flutter/material.dart';

class IsEven extends StatelessWidget {
  const IsEven(
    this.value, {
    super.key,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    if (value % 2 == 0) {
      return const Text('Even');
    }

    return const Text('Odd');
  }
}
