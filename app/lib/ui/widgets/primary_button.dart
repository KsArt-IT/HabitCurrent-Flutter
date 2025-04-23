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
      width: double.infinity,
      height: Constants.buttonHeight,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainerLow,
          foregroundColor: theme.colorScheme.onSurfaceVariant,

          disabledBackgroundColor: theme.colorScheme.tertiaryFixed,
          disabledForegroundColor: theme.colorScheme.onTertiaryFixed,

          textStyle: theme.textTheme.labelLarge,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.buttonRadius),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
