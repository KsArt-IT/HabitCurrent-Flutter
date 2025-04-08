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
          backgroundColor: theme.colorScheme.surfaceContainerLow,
          disabledBackgroundColor: theme.colorScheme.tertiaryFixed,
          foregroundColor: theme.colorScheme.onSecondary,
          disabledForegroundColor: theme.colorScheme.onTertiaryFixed,
          textStyle: theme.textTheme.labelLarge,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.buttonRadius),
          ),
          // elevation: 6,
        ),
        child: Text(label),
      ),
    );
  }
}
