import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final bool left;
  final bool disabled;
  final void Function() onPressed;
  const ArrowButton({
    super.key,
    this.left = true,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      color: theme.colorScheme.onPrimary,
      icon: left ? const Icon(Icons.chevron_left) : const Icon(Icons.chevron_right),
      onPressed: disabled ? null : onPressed,
    );
  }
}
