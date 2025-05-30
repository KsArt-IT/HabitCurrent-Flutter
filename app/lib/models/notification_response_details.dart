final class NotificationResponseDetails {
  final int id;
  final String identifier;
  final bool isOpen;
  final int? laterMinutes;

  NotificationResponseDetails({
    required this.id,
    required this.identifier,
    this.isOpen = false,
    this.laterMinutes,
  });
}
