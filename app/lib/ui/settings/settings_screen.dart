import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/gen/app_localizations.dart';
import 'package:habit_current/models/state_status.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';
import 'package:habit_current/ui/widgets/sized_outlined_button.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AppBloc>().add(AppReminderCheckEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AppBloc>().add(AppReminderCheckEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGranted = context.select(
      (AppBloc bloc) => bloc.state.reminder.isGranted,
    );

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.status == StateStatus.error && state.error != null) {
          context.read<AppBloc>().add(AppErrorEvent(state.error!));
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final strings = context.l10n;
        final theme = Theme.of(context);

        RadioListTile<T> radioListStyle<T>({
          required String title,
          required T value,
          required T groupValue,
          required ThemeData theme,
          required ValueChanged<T> onChanged,
        }) {
          return RadioListTile<T>(
            title: Text(
              title,
              style: value == groupValue
                  ? theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primaryFixed,
                    )
                  : theme.textTheme.titleSmall,
            ),
            visualDensity: VisualDensity.compact,
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            groupValue: groupValue,
            onChanged: (val) {
              if (val == null) return;
              onChanged(val);
            },
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Constants.paddingMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    strings.language,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppLocalizations.supportedLocales.length,
                    itemBuilder: (context, index) {
                      final value = AppLocalizations.supportedLocales[index].languageCode;
                      return radioListStyle<String>(
                        title: value,
                        value: value,
                        groupValue: state.languageCode,
                        theme: theme,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                            SettingsUpdateLanguageEvent(language: value),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  Text(
                    strings.theme,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ThemeMode.values.length,
                    itemBuilder: (context, index) {
                      final value = ThemeMode.values[index].name;
                      return radioListStyle<String>(
                        title: value,
                        value: value,
                        groupValue: state.themeCode,
                        theme: theme,
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(
                            SettingsUpdateThemeEvent(value),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  Text(
                    strings.notification,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: isGranted ? theme.colorScheme.onPrimary : theme.colorScheme.error,
                    ),
                  ),
                  if (!isGranted) ...[
                    const SizedBox(height: Constants.paddingMedium),
                    SizedOutlinedButton(
                      label: strings.requestPermission,
                      onPressed: () {
                        context.read<AppBloc>().add(AppReminderRequestEvent());
                      },
                    ),
                  ],
                  const SizedBox(height: Constants.paddingMedium),
                  SizedOutlinedButton(
                    label: strings.showTestNotification,
                    onPressed: () {
                      context.read<AppBloc>().add(
                        AppShowTestNotificationEvent(),
                      );
                    },
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  SizedOutlinedButton(
                    label: strings.openNotificationSettings,
                    onPressed: () {
                      context.read<AppBloc>().add(AppReminderOpenEvent());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
