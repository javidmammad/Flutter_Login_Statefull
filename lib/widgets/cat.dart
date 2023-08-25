import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  const Cat({super.key});

  @override
  Widget build(context) {
    return Image.asset(
      "assets/images/cat.png",
      fit: BoxFit.contain,
    );
  }
}
