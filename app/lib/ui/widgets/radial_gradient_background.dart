import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';

class RadialGradientBackground extends StatelessWidget {
  const RadialGradientBackground({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final radius = MediaQuery.of(context).size.longestSide / MediaQuery.of(context).size.shortestSide;

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            theme.colorScheme.tertiaryFixedDim,
            theme.colorScheme.onTertiaryFixedVariant,
          ],
          center: Alignment.topCenter,
          stops: const [0.3, 1.0],
          radius: 2,
        ),
      ),
      child: SafeArea(child: body),
    );
  }
}
