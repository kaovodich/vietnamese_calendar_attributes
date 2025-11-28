import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';
import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

const List<String> kCanNames = <String>[
  'Giáp',
  'Ất',
  'Bính',
  'Đinh',
  'Mậu',
  'Kỷ',
  'Canh',
  'Tân',
  'Nhâm',
  'Quý',
];

const List<String> kChiNames = <String>[
  'Tý',
  'Sửu',
  'Dần',
  'Mão',
  'Thìn',
  'Tỵ',
  'Ngọ',
  'Mùi',
  'Thân',
  'Dậu',
  'Tuất',
  'Hợi',
];

final List<CanChi> _sexagenaryCycle = List<CanChi>.generate(
  60,
  (int index) => CanChi(
    Can.values[index % Can.values.length],
    Chi.values[index % Chi.values.length],
  ),
);

int _cycleIndex(CanChi pair) =>
    _sexagenaryCycle.indexWhere((CanChi candidate) => candidate == pair);

int _hourBranchIndex(DateTime dateTime) {
  final int minutes = dateTime.hour * 60 + dateTime.minute;
  return ((minutes + 60) ~/ 120) % kChiNames.length;
}

CanChi _expectedMonthPair(LunarDate lunar) {
  final CanChi yearPair = lunar.canChiNam;
  final int startCanIndex =
      ((yearPair.can.index % 5) * 2 + 2) % Can.values.length;
  final int offset = (lunar.month - 1) % kChiNames.length;
  final Can expectedCan =
      Can.values[(startCanIndex + offset) % Can.values.length];
  final Chi expectedChi =
      Chi.values[(Chi.dan.index + offset) % kChiNames.length];
  return CanChi(expectedCan, expectedChi);
}

void main() {
  group('Category 1: Hour Can-Chi (Ngũ Thử Độn)', () {
    test('Boundary check 23:00 vs 00:00 respects day stems', () {
      final DateTime dayEnd = DateTime(2025, 6, 1, 23);
      final DateTime nextMidnight = DateTime(2025, 6, 2, 0);

      final CanChi dayStem = VnAttributeUtils.dayCanChiFromSolar(dayEnd);
      final CanChi nextDayStem =
          VnAttributeUtils.dayCanChiFromSolar(nextMidnight);

      final CanChi hourLate = VnAttributeUtils.hourCanChi(dayEnd);
      final CanChi hourEarly = VnAttributeUtils.hourCanChi(nextMidnight);

      final int tyIndex = 0;
      final Can expectedLateCan =
          Can.values[((dayStem.can.index % 5) * 2 + tyIndex) % 10];
      final Can expectedEarlyCan =
          Can.values[((nextDayStem.can.index % 5) * 2 + tyIndex) % 10];

      expect(hourLate.chi, Chi.ty,
          reason: '23:00 phải thuộc giờ Tý nhưng nhận ${hourLate.chi.vnName}');
      expect(hourLate.can, expectedLateCan,
          reason: 'Ngũ Thử Độn sai cho 23:00 (day stem ${dayStem.can.vnName})');

      expect(hourEarly.chi, Chi.ty,
          reason: '00:00 phải thuộc giờ Tý nhưng nhận ${hourEarly.chi.vnName}');
      expect(hourEarly.can, expectedEarlyCan,
          reason:
              'Ngũ Thử Độn sai cho 00:00 (day stem ${nextDayStem.can.vnName})');
    });

    test('Cycle check across 24 hours covering two days', () {
      final DateTime base = DateTime(2025, 11, 28);
      final List<DateTime> samples = <DateTime>[
        for (int day = 0; day < 2; day++)
          for (int hour = 0; hour < 24; hour += 2)
            DateTime(base.year, base.month, base.day + day, hour),
      ];

      for (final DateTime sample in samples) {
        final CanChi hourPair = VnAttributeUtils.hourCanChi(sample);
        final CanChi dayPair = VnAttributeUtils.dayCanChiFromSolar(sample);
        final int branchIndex = _hourBranchIndex(sample);

        final Chi expectedChi = Chi.values[branchIndex];
        expect(hourPair.chi, expectedChi,
            reason:
                'Giờ chi sai cho ${sample.toIso8601String()} (expected ${expectedChi.vnName}, actual ${hourPair.chi.vnName})');

        final int expectedCanIndex =
            ((dayPair.can.index % 5) * 2 + branchIndex) % kCanNames.length;
        final Can expectedCan = Can.values[expectedCanIndex];
        expect(hourPair.can, expectedCan,
            reason:
                'Ngũ Thử Độn sai cho ${sample.toIso8601String()} (expected ${expectedCan.vnName}, actual ${hourPair.can.vnName})');
      }
    });

    test('Cross-day branch transition 22:59 -> 23:01', () {
      final DateTime hoiMoment = DateTime(2025, 4, 4, 22, 59);
      final DateTime tyMoment = DateTime(2025, 4, 4, 23, 1);

      final Chi beforeChi = VnAttributeUtils.hourCanChi(hoiMoment).chi;
      final Chi afterChi = VnAttributeUtils.hourCanChi(tyMoment).chi;

      expect(beforeChi, Chi.hoi,
          reason: '22:59 phải thuộc giờ Hợi, nhận ${beforeChi.vnName}');
      expect(afterChi, Chi.ty,
          reason: '23:01 phải thuộc giờ Tý, nhận ${afterChi.vnName}');
    });
  });

  group('Category 2: Day Can-Chi continuity', () {
    test('30 consecutive days stay in sexagenary order', () {
      final DateTime start = DateTime(2024, 1, 1);
      CanChi previous = VnAttributeUtils.dayCanChiFromSolar(start);
      int prevIndex = _cycleIndex(previous);
      expect(prevIndex != -1, isTrue,
          reason: 'Không tìm thấy chỉ số Lục Thập Hoa Giáp cho ngày đầu');

      for (int offset = 1; offset < 30; offset++) {
        final DateTime current = start.add(Duration(days: offset));
        final CanChi currentPair = VnAttributeUtils.dayCanChiFromSolar(current);
        final int currentIndex = _cycleIndex(currentPair);
        expect(currentIndex, (prevIndex + 1) % _sexagenaryCycle.length,
            reason:
                'Ngày ${current.toIso8601String()} không nối tiếp đúng chu kỳ (trước đó ${previous.vnName})');
        previous = currentPair;
        prevIndex = currentIndex;
      }
    });

    test('Leap year boundary around 2024-02-29 increments by +1', () {
      final List<DateTime> dates = <DateTime>[
        DateTime(2024, 2, 27),
        DateTime(2024, 2, 28),
        DateTime(2024, 2, 29),
        DateTime(2024, 3, 1),
        DateTime(2024, 3, 2),
      ];

      final List<int> indices = dates
          .map((DateTime date) =>
              _cycleIndex(VnAttributeUtils.dayCanChiFromSolar(date)))
          .toList(growable: false);

      for (int i = 1; i < indices.length; i++) {
        expect(
          indices[i],
          (indices[i - 1] + 1) % _sexagenaryCycle.length,
          reason:
              'Chu kỳ ngày bị lệch tại ${dates[i].toIso8601String()} (expected +1)',
        );
      }
    });

    test('Anchor Nov 28 2025 (Tân Sửu) and offset verification', () {
      final DateTime anchorDate = DateTime(2025, 11, 28);
      final CanChi anchorPair = VnAttributeUtils.dayCanChiFromSolar(anchorDate);
      expect(anchorPair.can, Can.tan,
          reason:
              'Anchor ngày 2025-11-28 phải là Tân nhưng nhận ${anchorPair.can.vnName}');
      expect(anchorPair.chi, Chi.suu,
          reason:
              'Anchor ngày 2025-11-28 phải là Sửu nhưng nhận ${anchorPair.chi.vnName}');

      final List<int> offsets = <int>[1, 7, 25, 59];
      final int anchorIndex = _cycleIndex(anchorPair);

      for (final int offset in offsets) {
        final DateTime targetDate = anchorDate.add(Duration(days: offset));
        final CanChi targetPair =
            VnAttributeUtils.dayCanChiFromSolar(targetDate);
        final int expectedIndex =
            (anchorIndex + offset) % _sexagenaryCycle.length;
        expect(
          _cycleIndex(targetPair),
          expectedIndex,
          reason:
              'Ngày ${targetDate.toIso8601String()} lệch chu kỳ so với anchor +$offset',
        );
      }
    });
  });

  group('Category 3: Month Can-Chi (Ngũ Hổ Độn)', () {
    test('24 sequential months across 2024-2025 follow Ngũ Hổ Độn', () {
      final List<LunarDate> months = <LunarDate>[
        for (int year in <int>[2024, 2025])
          for (int month = 1; month <= 12; month++)
            LunarDate(day: 1, month: month, year: year, isLeap: false),
      ];

      for (final LunarDate lunar in months) {
        final CanChi actual = lunar.canChiThang;
        final CanChi expected = _expectedMonthPair(lunar);
        expect(actual.can, expected.can,
            reason:
                'Tháng ${lunar.month}/${lunar.year} sai Thiên Can (expected ${expected.can.vnName}, actual ${actual.can.vnName})');
        expect(actual.chi, expected.chi,
            reason:
                'Tháng ${lunar.month}/${lunar.year} sai Địa Chi (expected ${expected.chi.vnName}, actual ${actual.chi.vnName})');
      }
    });

    test('Year transition month 12 -> month 1 resets to Dần branch', () {
      final LunarDate dec2024 =
          LunarDate(day: 1, month: 12, year: 2024, isLeap: false);
      final LunarDate jan2025 =
          LunarDate(day: 1, month: 1, year: 2025, isLeap: false);

      final CanChi decPair = dec2024.canChiThang;
      final CanChi janPair = jan2025.canChiThang;

      expect(decPair.chi, Chi.values[(Chi.dan.index + 11) % kChiNames.length],
          reason: 'Tháng 12 phải kết thúc tại Chi trước Dần');
      expect(janPair.chi, Chi.dan,
          reason: 'Tháng Giêng luôn phải là Dần theo Ngũ Hổ Độn');
    });

    test('Specific Giáp/Ất/Kỷ year expectations', () {
      final LunarDate giapYear =
          LunarDate(day: 1, month: 1, year: 2024, isLeap: false);
      expect(
        giapYear.canChiThang.vnName,
        'Bính Dần',
        reason: 'Năm Giáp tháng Giêng phải là Bính Dần',
      );

      final LunarDate atYear =
          LunarDate(day: 1, month: 1, year: 2025, isLeap: false);
      expect(
        atYear.canChiThang.vnName,
        'Mậu Dần',
        reason: 'Năm Ất tháng Giêng phải là Mậu Dần',
      );

      final LunarDate kyYear =
          LunarDate(day: 1, month: 1, year: 2019, isLeap: false);
      expect(
        kyYear.canChiThang.vnName,
        'Bính Dần',
        reason: 'Năm Kỷ tháng Giêng phải là Bính Dần',
      );
    });
  });

  group('Category 4: Year Can-Chi formula', () {
    test('20 sample years match (Year-4) mod formulas', () {
      const List<int> sampleYears = <int>[
        1890,
        1900,
        1912,
        1925,
        1930,
        1933,
        1945,
        1954,
        1960,
        1968,
        1975,
        1984,
        1990,
        1999,
        2000,
        2008,
        2016,
        2024,
        2025,
        2077,
      ];

      for (final int year in sampleYears) {
        final LunarDate lunar =
            LunarDate(day: 1, month: 1, year: year, isLeap: false);
        final CanChi actual = lunar.canChiNam;
        final Can expectedCan = Can.values[(year - 4) % kCanNames.length];
        final Chi expectedChi = Chi.values[(year - 4) % kChiNames.length];

        expect(actual.can, expectedCan,
            reason:
                'Nam $year sai Thiên Can (expected ${expectedCan.vnName}, actual ${actual.can.vnName})');
        expect(actual.chi, expectedChi,
            reason:
                'Nam $year sai Địa Chi (expected ${expectedChi.vnName}, actual ${actual.chi.vnName})');
      }
    });
  });
}
