import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';

@RoutePage()
class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final S strings = S.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              theme.colorScheme.tertiaryFixed,
              theme.colorScheme.onTertiaryFixed,
            ],
            center: Alignment.topCenter,
            stops: [0.3, 1.0],
            radius: 2.3,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Image.asset(theme.getImagePath('onboard_logo.png')),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset(theme.getImagePath('onboard_hello.png')),
                    Spacer(),
                    PrimaryButton(
                      label: strings.continues,
                      onPressed: () {
                        context.router.replace(const HelloRoute());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
