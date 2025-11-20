final class HourInterval {
  final int id;
  final int time;

  const HourInterval({this.id = 0, required this.time});

  HourInterval copyWith({int? time}) => HourInterval(
    id: id,
    time: time ?? this.time,
  );
}
