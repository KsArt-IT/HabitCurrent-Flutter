final class HourInterval {
  final int id;
  final int time;

  const HourInterval({required this.id, required this.time});

  HourInterval copyWith({int? time}) => HourInterval(
    id: this.id,
    time: time ?? this.time, //
  );
}
