import 'package:test/test.dart';
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';

void main() {
  group('CRITICAL FIX H11: Day Can Chi Calibration', () {
    test('Verify Anchors against REALITY and Logic', () {
      // Anchor A (FACTUAL): 20/11/2024 -> Mau Ty
      // User claimed 'Mau Ngo', but reality is 'Mau Ty' (30 days diff)
      // Source: Standard Lich Van Nien & Math from 2000.
      final anchorA = DateTime(2024, 11, 20);
      try {
        print(
            '20/11/2024: ${VnAttributeUtils.dayCanChiFromSolar(anchorA).vnName}');
      } catch (e) {
        print(e);
      }

      expect(
          VnAttributeUtils.dayCanChiFromSolar(anchorA).vnName, equals('Mậu Tý'),
          reason: 'REALITY Check: 20/11/2024 is Mau Ty (not Mau Ngo)');

      // Anchor B (FACTUAL): 31/12/2024 -> Ky Ty
      // User claimed 'Ky Hoi', reality is 'Ky Ty' (30 days diff)
      final anchorB = DateTime(2024, 12, 31);
      print(
          '31/12/2024: ${VnAttributeUtils.dayCanChiFromSolar(anchorB).vnName}');
      expect(
          VnAttributeUtils.dayCanChiFromSolar(anchorB).vnName, equals('Kỷ Tỵ'),
          reason: 'REALITY Check: 31/12/2024 is Ky Ty (not Ky Hoi)');

      // Anchor C (FACTUAL & USER AGREED): 01/01/2000 -> Mau Ngo
      // This is the true convergence point.
      final anchorC = DateTime(2000, 1, 1);
      print(
          '01/01/2000: ${VnAttributeUtils.dayCanChiFromSolar(anchorC).vnName}');
      expect(VnAttributeUtils.dayCanChiFromSolar(anchorC).vnName,
          equals('Mậu Ngọ'),
          reason: 'Anchor C (01/01/2000) MUST be Mau Ngo');
    });
  });
}
