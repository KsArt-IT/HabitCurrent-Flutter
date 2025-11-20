enum Reminder {
  enabled,
  disabled,
  request,
  open
  ;

  bool get isGranted => this == Reminder.enabled || this == Reminder.disabled;
}
