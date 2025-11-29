import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';

class SizedOutlinedButton extends StatelessWidget {
  const SizedOutlinedButton({
    super.key,
    required this.label,
    this.disabled = false,
    this.negative = false,
    this.onPressed,
  });

  final String label;
  final bool disabled;
  final bool negative;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: .infinity,
      height: Constants.buttonHeight,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: negative
              ? theme.colorScheme.error
              : theme.colorScheme.onTertiaryContainer,
          disabledForegroundColor: theme.colorScheme.onTertiaryFixed,
          disabledBackgroundColor: theme.colorScheme.tertiaryFixed,
          textStyle: theme.textTheme.labelLarge,
          side: .new(
            color: disabled
                ? Colors.transparent
                : (negative ? theme.colorScheme.error : theme.colorScheme.onTertiaryContainer),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(Constants.buttonRadius),
          ),
        ),
        child: Text(
          label,
          textAlign: .center,
          textScaler: const .linear(1),
          maxLines: 1,
        ),
      ),
    );
  }
}
