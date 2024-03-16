import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: const Center(
      child: Text("This is temp screen, Used for testing purpose."),
    ));
  }
}
