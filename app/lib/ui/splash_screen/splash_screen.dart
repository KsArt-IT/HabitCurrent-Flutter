import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/widgets/radial_gradient_background.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.router.replace(const OnboardRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final S strings = S.of(context);

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
