library vietnamese_holidays;

import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

/// Represents a Vietnamese holiday (solar or lunar).
class Holiday {
  const Holiday({
    required this.name,
    required this.isLunar,
    required this.day,
    required this.month,
    this.isDayOff = false,
  })  : assert(day >= 1 && day <= 31),
        assert(month >= 1 && month <= 12);

  final String name;
  final bool isLunar;
  final int day;
  final int month;
  final bool isDayOff;

  bool matchesSolar(DateTime date) =>
      !isLunar && date.day == day && date.month == month;

  bool matchesLunar(LunarDate date) =>
      isLunar && date.day == day && date.month == month;
}

/// Utilities to query Vietnamese holidays.
class VnHolidayUtils {
  const VnHolidayUtils._();

  static const VnLunarCore _core = VnLunarCore();

  static final List<Holiday> _holidays = <Holiday>[
    // Solar holidays
    const Holiday(
      name: 'Tết Dương Lịch',
      isLunar: false,
      day: 1,
      month: 1,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Valentine',
      isLunar: false,
      day: 14,
      month: 2,
    ),
    const Holiday(
      name: 'Quốc tế Phụ nữ',
      isLunar: false,
      day: 8,
      month: 3,
    ),
    const Holiday(
      name: 'Giải phóng miền Nam',
      isLunar: false,
      day: 30,
      month: 4,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Quốc tế Lao động',
      isLunar: false,
      day: 1,
      month: 5,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Quốc khánh',
      isLunar: false,
      day: 2,
      month: 9,
      isDayOff: true,
    ),
    // Lunar holidays
    const Holiday(
      name: 'Tết Nguyên Đán (Mùng 1)',
      isLunar: true,
      day: 1,
      month: 1,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Tết Nguyên Đán (Mùng 2)',
      isLunar: true,
      day: 2,
      month: 1,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Tết Nguyên Đán (Mùng 3)',
      isLunar: true,
      day: 3,
      month: 1,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Tết Nguyên Tiêu',
      isLunar: true,
      day: 15,
      month: 1,
    ),
    const Holiday(
      name: 'Giỗ tổ Hùng Vương',
      isLunar: true,
      day: 10,
      month: 3,
      isDayOff: true,
    ),
    const Holiday(
      name: 'Lễ Phật Đản',
      isLunar: true,
      day: 15,
      month: 4,
    ),
    const Holiday(
      name: 'Tết Đoan Ngọ',
      isLunar: true,
      day: 5,
      month: 5,
    ),
    const Holiday(
      name: 'Vu Lan',
      isLunar: true,
      day: 15,
      month: 7,
    ),
    const Holiday(
      name: 'Tết Trung Thu',
      isLunar: true,
      day: 15,
      month: 8,
    ),
    const Holiday(
      name: 'Ông Công Ông Táo',
      isLunar: true,
      day: 23,
      month: 12,
    ),
  ];

  /// Returns the list of configured holidays.
  static List<Holiday> get holidays => List<Holiday>.unmodifiable(_holidays);

  /// Returns holidays happening on the provided solar [date].
  static List<Holiday> getHolidays(DateTime date) {
    final LunarDate lunarDate = _core.convertSolarToLunar(date);
    return _holidays
        .where(
          (Holiday holiday) =>
              holiday.matchesSolar(date) || holiday.matchesLunar(lunarDate),
        )
        .toList(growable: false);
  }

  /// Returns all public holiday dates in the Gregorian [year].
  static List<DateTime> getPublicHolidaysInYear(int year) {
    final DateTime start = DateTime(year, 1, 1);
    final DateTime end = DateTime(year + 1, 1, 1);
    final List<DateTime> daysOff = <DateTime>[];
    for (DateTime cursor = start;
        cursor.isBefore(end);
        cursor = cursor.add(const Duration(days: 1))) {
      final bool isDayOff =
          getHolidays(cursor).any((Holiday holiday) => holiday.isDayOff);
      if (isDayOff) {
        daysOff.add(cursor);
      }
    }
    return daysOff;
  }

  /// Converts a lunar [holiday] to solar date within [year].
  static DateTime? lunarHolidayToSolarDate(Holiday holiday, int year) {
    if (!holiday.isLunar) {
      return null;
    }
    return _core.convertLunarToSolar(holiday.day, holiday.month, year, false);
  }
}

extension HolidayExt on DateTime {
  /// Whether this date matches at least one configured Vietnamese holiday.
  bool get isVietnameseHoliday => VnHolidayUtils.getHolidays(this).isNotEmpty;

  /// The Vietnamese holiday names for this date.
  List<String> get holidayNames => VnHolidayUtils.getHolidays(this)
      .map((Holiday holiday) => holiday.name)
      .toList(growable: false);
}
