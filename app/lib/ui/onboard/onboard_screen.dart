import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';
import 'package:habit_current/ui/widgets/radial_gradient_background.dart';

@RoutePage()
class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;
    final AppBloc appBloc = context.read<AppBloc>();
    debugPrint('OnboardScreen build');

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
                    appBloc.add(AppInitNameEvent());
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
