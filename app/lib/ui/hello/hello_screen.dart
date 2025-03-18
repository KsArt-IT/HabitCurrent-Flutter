import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';

@RoutePage()
class HelloScreen extends StatefulWidget {
  const HelloScreen({super.key});

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateName() {
    final name = _nameController.text.trim();
    final isValid = _isValidName(name);
    if (_isNameValid != isValid) {
      setState(() {
        _isNameValid = isValid;
      });
    }
  }

  bool _isValidName(String name) {
    if (name.isEmpty) return false;
    if (name.length < 3 || name.length > 20) return false;
    // Проверка на наличие только букв (кириллица и латиница)
    return RegExp(r'^[іІїЇєЄґҐʼа-яА-Яa-zA-Z\s]+$').hasMatch(name);
  }

  String? _getNameErrorText(String? value) {
    final S strings = S.of(context);
    final name = value?.trim() ?? '';
    if (name.isEmpty || name.length < 3 || name.length > 20) {
      return strings.nameErrorEmpty;
    }
    if (!RegExp(r'^[іІїЇєЄґҐʼа-яА-Яa-zA-Z\s]+$').hasMatch(name)) {
      return strings.nameErrorInvalid;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final S strings = S.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Constants.paddingMedium),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(strings.welcome, style: theme.textTheme.titleLarge),
                Text(strings.enterYourName, style: theme.textTheme.bodyMedium),
                Spacer(),
                TextFormField(
                  controller: _nameController,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: strings.namePlaceholder,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                    errorStyle: TextStyle(color: theme.colorScheme.error),
                    filled: true,
                    fillColor: theme.colorScheme.tertiaryContainer,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Constants.textFieldPaddingHorizontal,
                      vertical: Constants.textFieldPaddingVertical,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.textFieldRadius,
                      ),
                      borderSide: BorderSide(
                        color: theme.colorScheme.tertiaryFixedDim,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.textFieldRadius,
                      ),
                      borderSide: BorderSide(
                        color: theme.colorScheme.tertiaryFixedDim,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.textFieldRadius,
                      ),
                      borderSide: BorderSide(
                        color: theme.colorScheme.tertiaryFixedDim,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.textFieldRadius,
                      ),
                      borderSide: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Constants.textFieldRadius,
                      ),
                      borderSide: BorderSide(
                        color: theme.colorScheme.error,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: _getNameErrorText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: Constants.textFieldSpacing),
                PrimaryButton(
                  label: strings.continues,
                  disabled: !_isNameValid,
                  onPressed: () {
                    context.router.replace(const HomeRoute());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
