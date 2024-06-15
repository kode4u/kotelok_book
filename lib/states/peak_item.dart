import 'dart:convert';

class PeakItem {
  int peak;
  String count = "";

  PeakItem.fromInput({int? peak, String? count})
      : peak = peak!,
        count = count!;

  PeakItem.fromJson(Map<String, dynamic> parsedJson)
      : peak = int.parse('${parsedJson['peak']}'),
        count = '${parsedJson['count']}';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "peak": peak,
      "count": count,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
