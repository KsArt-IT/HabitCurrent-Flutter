import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/generated/l10n.dart';

class HabitNameEdit extends StatefulWidget {
  const HabitNameEdit({super.key, required this.onChanged});

  final String initialValue = '';
  final Function(String) onChanged;

  @override
  State<HabitNameEdit> createState() => _HabitNameEditState();
}

class _HabitNameEditState extends State<HabitNameEdit> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final S strings = S.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.paddingMedium),
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            // fillColor: theme.colorScheme.surface,
            // hintText: strings.habitEnterNameHint,
            // hintStyle: theme.textTheme.bodyMedium,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
