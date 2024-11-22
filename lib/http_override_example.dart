import 'package:flutter/material.dart';

class HttpOverrideExample extends StatelessWidget {
  const HttpOverrideExample({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(imageUrl),
    );
  }
}
