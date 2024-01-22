import 'package:flutter/material.dart';

class LoadingWheel extends StatelessWidget {
  const LoadingWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
