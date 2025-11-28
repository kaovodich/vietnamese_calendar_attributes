import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_holidays.dart';
import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

void main() {
  group('Holiday lookup', () {
    test('Detects solar holiday', () {
      final DateTime nationalDay = DateTime(2024, 9, 2);
      expect(nationalDay.isVietnameseHoliday, isTrue);
      expect(
        nationalDay.holidayNames,
        contains('Quốc khánh'),
      );
    });

    test('Detects lunar holiday (Tết 2024)', () {
      final DateTime tet = DateTime(2024, 2, 10);
      final List<String> names = tet.holidayNames;
      expect(names, contains('Tết Nguyên Đán (Mùng 1)'));
      expect(tet.isVietnameseHoliday, isTrue);
    });

    test('Non-holiday date returns empty', () {
      final DateTime randomDate = DateTime(2024, 6, 2);
      expect(randomDate.isVietnameseHoliday, isFalse);
      expect(randomDate.holidayNames, isEmpty);
    });
  });

  group('Public holiday aggregation', () {
    const int year = 2024;
    final List<DateTime> daysOff = VnHolidayUtils.getPublicHolidaysInYear(year);

    test('Includes all configured solar public days', () {
      expect(
        daysOff,
        containsAll(<DateTime>[
          DateTime(year, 1, 1),
          DateTime(year, 4, 30),
          DateTime(year, 5, 1),
          DateTime(year, 9, 2),
        ]),
      );
    });

    test('Includes three Tet days via lunar matching', () {
      final VnLunarCore core = VnLunarCore();
      final List<DateTime> tetMatches = daysOff.where((DateTime date) {
        final LunarDate lunar = core.convertSolarToLunar(date);
        return lunar.month == 1 && lunar.day >= 1 && lunar.day <= 3;
      }).toList();
      expect(tetMatches.length, 3);
    });
  });

  group('Holiday database exposure', () {
    test('Expose immutable list', () {
      expect(
          () => VnHolidayUtils.holidays
              .add(const Holiday(name: '', isLunar: false, day: 1, month: 1)),
          throwsUnsupportedError);
    });
  });
}
