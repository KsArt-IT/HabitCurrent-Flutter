import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.disabled = false,
    required this.onPressed,
  });

  final String label;
  final bool disabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: Constants.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          disabledBackgroundColor: theme.colorScheme.secondaryFixed,
          foregroundColor: theme.colorScheme.onSecondary,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.buttonRadius),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
