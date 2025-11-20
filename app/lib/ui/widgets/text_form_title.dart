import 'package:flutter/material.dart';

class TextFormTitle extends StatelessWidget {
  const TextFormTitle(this.title, {super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}
