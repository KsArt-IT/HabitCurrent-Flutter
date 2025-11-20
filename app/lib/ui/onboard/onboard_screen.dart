import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/ui/initial/bloc/initial_bloc.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';
import 'package:habit_current/ui/widgets/radial_gradient_background.dart';

@RoutePage()
class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return RadialGradientBackground(
      body: Column(
        children: [
          Expanded(child: Image.asset(theme.getImagePath('onboard_logo.png'))),
          Expanded(
            child: Column(
              children: [
                Image.asset(theme.getImagePath('onboard_hello.png')),
                Spacer(),
                PrimaryButton(
                  label: strings.continueBtn,
                  onPressed: () {
                    context.read<InitialBloc>().add(InitialHelloEvent());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
