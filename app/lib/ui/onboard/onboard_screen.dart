import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/images.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';

@RoutePage()
class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.tertiaryContainer,
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
              child: Image.asset(
                ThemeImage.getPath('onboard_logo.png', context),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Image.asset(ThemeImage.getPath('onboard_hello.png', context)),
                  Spacer(),
                  PrimaryButton(
                    label: S.of(context).continues,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
