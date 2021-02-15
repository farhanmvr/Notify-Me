import 'package:flutter/material.dart';

class Bubbles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 8,color: Colors.green),
        Icon(Icons.circle, size: 8,color: Colors.green),
        Icon(Icons.circle, size: 8,color: Theme.of(context).errorColor),
        Icon(Icons.circle, size: 8,color: Colors.green),
        Icon(Icons.circle, size: 8,color: Theme.of(context).errorColor),
      ],
    );
  }
}
