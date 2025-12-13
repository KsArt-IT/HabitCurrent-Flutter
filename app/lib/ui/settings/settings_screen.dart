import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/core/extension/string_ext.dart';
import 'package:habit_current/gen/app_localizations.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';
import 'package:habit_current/ui/widgets/sized_outlined_button.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  late AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appBloc = context.read()..add(AppReminderCheckEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _appBloc.add(AppReminderCheckEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isGranted = context.select(
      (AppBloc bloc) => bloc.state.reminder.isGranted,
    );

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.status == .error && state.error != null) {
          _appBloc.add(AppErrorEvent(state.error!));
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
            visualDensity: .compact,
            dense: true,
            contentPadding: .zero,
            controlAffinity: .leading,
            materialTapTargetSize: .shrinkWrap,
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
              padding: const .all(Constants.paddingMedium),
              child: Column(
                children: [
                  Text(
                    strings.language,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppLocalizations.supportedLocales.length + 1,
                    itemBuilder: (context, index) {
                      final value = index == 0
                          ? Constants.system
                          : AppLocalizations.supportedLocales[index - 1].languageCode;
                      return radioListStyle<String>(
                        title: value.toLanguageTitle(strings),
                        value: value,
                        groupValue: state.languageCode,
                        theme: theme,
                        onChanged: (value) => context.read<SettingsBloc>().add(
                          SettingsUpdateLanguageEvent(language: value),
                        ),
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
                        title: value.toThemeTitle(strings),
                        value: value,
                        groupValue: state.themeCode,
                        theme: theme,
                        onChanged: (value) => context.read<SettingsBloc>().add(
                          SettingsUpdateThemeEvent(value),
                        ),
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
                      onPressed: () => _appBloc.add(AppReminderRequestEvent()),
                    ),
                  ],
                  const SizedBox(height: Constants.paddingMedium),
                  SizedOutlinedButton(
                    label: strings.showTestNotification,
                    onPressed: () => _appBloc.add(
                      AppShowTestNotificationEvent(
                        title: strings.notificationTestTitle,
                        body: strings.notificationTestBody,
                        payload: strings.notificationTestPayload,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  SizedOutlinedButton(
                    label: strings.openNotificationSettings,
                    onPressed: () => _appBloc.add(AppReminderOpenEvent()),
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
