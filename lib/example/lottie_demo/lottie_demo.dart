import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieDemo extends StatelessWidget {
  const LottieDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: Lottie.asset('assets/walk.json'),
      ),
    );
  }
}
