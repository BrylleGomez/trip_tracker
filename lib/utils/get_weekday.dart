// ignore_for_file: constant_identifier_names

enum Weekday { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday }

extension WeekdayUtils on Weekday {
  static String enumToStr(Weekday weekdayEnum) {
    return weekdayEnum.toString().replaceAll('Weekday.', '');
  }

  static Weekday strToEnum(String weekdayStr) {
    return Weekday.values
        .firstWhere((e) => e.toString() == 'Weekday.$weekdayStr');
  }

  static Weekday weekdayFromDatetime(DateTime date) {
    const Map<int, Weekday> weekdays = {
      1: Weekday.Monday,
      2: Weekday.Tuesday,
      3: Weekday.Wednesday,
      4: Weekday.Thursday,
      5: Weekday.Friday,
      6: Weekday.Saturday,
      7: Weekday.Sunday,
    };
    return weekdays[date.weekday] ?? Weekday.Thursday;
  }
}
