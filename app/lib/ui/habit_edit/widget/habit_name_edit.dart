import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';
import 'package:habit_current/ui/widgets/text_form_title.dart';

class HabitNameEditWidget extends StatefulWidget {
  final String? initialName;
  final bool isEditing;
  const HabitNameEditWidget({super.key, this.initialName}) : isEditing = initialName != null;

  @override
  State<HabitNameEditWidget> createState() => _HabitNameEditWidgetState();
}

class _HabitNameEditWidgetState extends State<HabitNameEditWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void didUpdateWidget(HabitNameEditWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialName != oldWidget.initialName && widget.initialName != _controller.text) {
      _controller.text = widget.initialName ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormTitle(strings.habitEnterName),
          SizedBox(height: Constants.paddingMedium),
          TextField(
            controller: _controller,
            style: theme.textTheme.bodyLarge,
            cursorColor: theme.colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.textFieldRadius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.textFieldRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Constants.textFieldRadius),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: theme.colorScheme.secondaryContainer,
              hintText: strings.habitEnterNameHint,
              hintStyle: theme.textTheme.headlineSmall,
              errorStyle: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Constants.textFieldPaddingHorizontal,
                vertical: Constants.textFieldPaddingVertical,
              ),
            ),
            onChanged: (value) {
              context.read<HabitEditBloc>().add(
                UpdateHabitNameEvent(name: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
