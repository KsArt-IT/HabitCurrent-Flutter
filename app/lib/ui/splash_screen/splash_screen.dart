import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/widgets/radial_gradient_background.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final S strings = S.of(context);
    debugPrint('SplashScreen build');

    return RadialGradientBackground(
      body: Column(
        children: [
          Expanded(child: Image.asset(theme.getImagePath('onboard_logo.png'))),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(strings.appTitle, style: theme.textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
