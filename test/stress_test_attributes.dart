import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';
import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

void main() {
  group('QA Stress Test - Can-Chi Logic', () {
    test('Test 1.1: The Rat Hour Dilemma (Dạ Tý vs Chính Tý)', () {
      print('\n--- Test 1.1: The Rat Hour Dilemma ---');
      // Scenario A: 23:15 on Nov 20, 2024
      final dateTimeA = DateTime(2024, 11, 20, 23, 15);
      // Scenario B: 00:15 on Nov 21, 2024
      final dateTimeB = DateTime(2024, 11, 21, 0, 15);

      final hourCanChiA = dateTimeA.hourCanChiName;
      final hourCanChiB = dateTimeB.hourCanChiName;

      print('Scenario A (2024-11-20 23:15): $hourCanChiA');
      print('Scenario B (2024-11-21 00:15): $hourCanChiB');

      // Manual verification: we expect consistency or a specific transition
      // But for this stress test, we just output as requested.
    });

    test('Test 1.2: Month Stem Consistency (Ngũ Hổ Độn)', () {
      print('\n--- Test 1.2: Month Stem Consistency ---');

      // Input 1: Year 2024 (Giáp), Month 1
      // Creating a dummy LunarDate. Attributes typically rely on year/month.
      // We assume day 1, no leap for simplicity as we just check Month CanChi.
      final lunar2024 = LunarDate(day: 1, month: 1, year: 2024, isLeap: false);

      // Input 2: Year 2029 (Kỷ), Month 1
      final lunar2029 = LunarDate(day: 1, month: 1, year: 2029, isLeap: false);

      final monthCanChi2024 = lunar2024.canChiThang.vnName;
      final monthCanChi2029 = lunar2029.canChiThang.vnName;

      print('Input 1 (Year 2024, Month 1): $monthCanChi2024');
      print('Input 2 (Year 2029, Month 1): $monthCanChi2029');

      // Verification Logic
      // Giáp (2024) -> Earth. Kỷ (2029) -> Earth.
      // Earth Year -> Month 1 starts with Bính Dần.
      expect(monthCanChi2024, equals('Bính Dần'),
          reason: '2024 Month 1 should be Bính Dần');
      expect(monthCanChi2029, equals('Bính Dần'),
          reason: '2029 Month 1 should be Bính Dần');
      expect(monthCanChi2024, equals(monthCanChi2029),
          reason: 'Month Stems should match for Giáp and Kỷ years');
    });
  });
}
