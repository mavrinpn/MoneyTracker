import 'package:module_business/module_business.dart';

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime addYears(int years) {
    return copyWith(year: year + years);
  }

  DateTime addMonths(int months) {
    return copyWith(month: month + months);
  }

  DateTime addWeeks(int weeks) {
    return copyWith(day: day + weeks * 7);
  }

  DateTime addDays(int days) {
    return copyWith(day: day + days);
  }

  static DateTime fromPeriod(Period period) {
    return DateTime(period.year, period.month);
  }
}
