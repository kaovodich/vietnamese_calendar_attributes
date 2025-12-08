import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';

void main() {
  group('Day Can Chi Bug Audit', () {
    test('31/12/2024 should be Mau Than', () {
      final date = DateTime(2024, 12, 31);
      final canChi = VnAttributeUtils.dayCanChiFromSolar(date);
      print('31/12/2024 Returns: ${canChi.vnName}');

      // We expect 'Mậu Thân' but user identifies bug makes it 'Mậu Tuất'
      expect(canChi.vnName, 'Mậu Thân',
          reason: 'Critical Bug: 31/12/2024 MUST be Mau Than');
    });

    test('20/11/2024 should be Giap Thin', () {
      final date = DateTime(2024, 11, 20);
      final canChi = VnAttributeUtils.dayCanChiFromSolar(date);
      print('20/11/2024 Returns: ${canChi.vnName}');
      expect(canChi.vnName, 'Giáp Thìn',
          reason: 'Control Date: 20/11/2024 MUST be Giap Thin');
    });
  });
}
