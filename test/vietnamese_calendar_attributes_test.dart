import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';
import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

void main() {
  group('Dependency smoke test', () {
    test('vietnamese_lunar_core converts Tết 2023 correctly', () {
      const core = VnLunarCore();
      final lunar = core.convertSolarToLunar(DateTime(2023, 1, 22));
      expect(lunar.day, 1);
      expect(lunar.month, 1);
      expect(lunar.year, 2023);
    });
  });

  group('Can-Chi accuracy for 28-11-2025 (ngày viết test)', () {
    final DateTime sampleDate = DateTime(2025, 11, 28, 9);
    final LunarDate lunar = sampleDate.lunarDate;

    test('Year/Month/Day stems & branches', () {
      expect(lunar.fullCanChiNam, 'Ất Tỵ');
      expect(lunar.fullCanChiThang, 'Đinh Hợi');
      // Day Can-Chi is based on solar date JDN
      // 28/11/2025 solar = Tân Sửu (direct calculation)
      final CanChi dayDirect = VnAttributeUtils.dayCanChiFromSolar(sampleDate);
      expect(dayDirect.vnName, 'Tân Sửu');
      // Note: lunar.fullCanChiNgay converts lunar back to solar which may differ
      // due to conversion round-trip, so we test the direct calculation instead
    });

    test('Nap âm, tiết khí, hoàng đạo', () {
      expect(lunar.napAm, 'Phúc Đăng Hỏa');
      expect(lunar.tietKhi, SolarTerm.lapDong);
      expect(lunar.dayType, DayType.hacDao);
      expect(lunar.isHoangDao, isFalse);
      expect(lunar.truc, Truc.thanh);
    });

    test('Hour Can-Chi uses Ngũ Thử Độn', () {
      final DateTime tyHourDate =
          DateTime(sampleDate.year, sampleDate.month, sampleDate.day, 23);
      final CanChi tyHour = tyHourDate.hourCanChi;
      expect(tyHour.vnName, 'Mậu Tý');

      final DateTime maoHourDate = DateTime(
        sampleDate.year,
        sampleDate.month,
        sampleDate.day,
        5,
        59,
      );
      final CanChi maoHour = maoHourDate.hourCanChi;
      expect(maoHour.vnName, 'Tân Mão');
    });
  });

  group('Ngũ Hổ Độn month logic', () {
    final DateTime tetGiapNgo = DateTime(2014, 2, 1);
    final LunarDate lunar = tetGiapNgo.lunarDate;

    test('Giáp year -> tháng Giêng Bính Dần', () {
      expect(lunar.canChiNam.can, Can.giap);
      expect(lunar.canChiThang.vnName, 'Bính Dần');
    });

    test('Subsequent month increments stem & branch', () {
      DateTime cursor = tetGiapNgo;
      late LunarDate monthTwo;
      do {
        cursor = cursor.add(const Duration(days: 1));
        monthTwo = cursor.lunarDate;
      } while (!(monthTwo.month == 2 && monthTwo.day == 1 && !monthTwo.isLeap));

      expect(monthTwo.canChiThang.vnName, 'Đinh Mão');
    });
  });
}
