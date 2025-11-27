enum Reminder {
  enabled,
  disabled,
  request,
  open,
  ;

  bool get isGranted => this == .enabled || this == .disabled;
}
