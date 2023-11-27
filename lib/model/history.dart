import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  final String name;
  final int after;
  final int before;
  final String date;
  final bool isUp;

  History({
    required this.name,
    required this.after,
    required this.before,
    required this.date,
    required this.isUp,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  static List<History> getHistoriesFromJson(List<dynamic> list) {
    return List<History>.from(list.map((x) => History.fromJson(x)));
  }
}
