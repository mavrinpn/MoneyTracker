class Period {
  int year = 1970;
  int month = 1;

  Period({required int year, required int month})
      : year = year < 1970 ? 1970 : year,
        month = month < 1 ? 1 : (month > 12 ? 12 : month);

  Period.current() {
    final now = DateTime.now();
    year = now.year;
    month = now.month;
  }

  bool isCurrent() {
    final now = DateTime.now();
    return now.year == year && now.month == month;
  }

  DateTime startDate() {
    return DateTime(year, month);
  }

  DateTime endDate() {
    return DateTime(year, month + 1);
  }
}
