# vietnamese_calendar_attributes

A comprehensive Dart/Flutter package that extends `vietnamese_lunar_core` with Vietnamese cultural, Feng Shui, and spiritual attributes. While the Core library handles the mathematical conversion between solar and lunar calendars, this package provides the **cultural layer**—everything from Can-Chi (Heavenly Stems & Earthly Branches) to Feng Shui elements and astrology.

## 🎯 Key Features

- **Type-Safe Design**: Uses strict Enums (`Can`, `Chi`, `NguHanh`, `Truc`, `SolarTerm`) instead of raw strings to prevent typos and ensure compile-time safety
- **Traditional Algorithms**: Implements authentic Vietnamese methods:
  - **Ngũ Hổ Độn** (Five Tigers) for Month Can-Chi calculation
  - **Ngũ Thử Độn** (Five Rats) for Hour Can-Chi calculation
- **Complete Can-Chi System**: Calculates Heavenly Stems & Earthly Branches for:
  - Year (Can-Chi Năm)
  - Month (Can-Chi Tháng)
  - Day (Can-Chi Ngày)
  - Hour (Can-Chi Giờ) - with minute-level precision
- **Feng Shui Elements**:
  - **Nap Am** (Melodic Elements): 60-element system (e.g., "Lộ Bàng Thổ", "Phúc Đăng Hỏa")
  - **Ngũ Hành** (Five Elements): Kim, Mộc, Thủy, Hỏa, Thổ
- **Astrology & Divination**:
  - **Tiết Khí** (Solar Terms): 24 solar terms (Lập Xuân, Kinh Trập, Thanh Minh, etc.)
  - **Trực** (Day Officers): 12-day cycle (Kiến, Trừ, Mãn, Bình, etc.)
  - **Hoàng Đạo / Hắc Đạo**: Lucky and unlucky days based on traditional zodiac rules

## 📦 Installation

Since this package is currently hosted on GitHub (not yet published to pub.dev), add it to your `pubspec.yaml` using the `git` dependency:

```yaml
dependencies:
  vietnamese_calendar_attributes:
    git:
      url: https://github.com/kaovodich/vietnamese_calendar_attributes.git
      ref: main
```

Then run:

```bash
dart pub get
```

**Note**: This package depends on `vietnamese_lunar_core`, which will be automatically installed as a transitive dependency.

## 🚀 Quick Start

### Basic Usage: Get Full Cultural Info for a Date

```dart
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';

void main() {
  // Convert a solar date to lunar
  final DateTime solarDate = DateTime(2025, 11, 28);
  final LunarDate lunar = solarDate.lunarDate;
  
  // Get complete Can-Chi information
  print('Năm ${lunar.fullCanChiNam}');        // Output: Năm Ất Tỵ
  print('Tháng ${lunar.fullCanChiThang}');     // Output: Tháng Đinh Hợi
  print('Ngày ${lunar.fullCanChiNgay}');      // Output: Ngày Tân Sửu
  
  // Get Feng Shui and astrology attributes
  print('Tiết Khí: ${lunar.tietKhi.vnName}'); // Output: Tiết Khí: Lập Đông
  print('Trực: ${lunar.truc.vnName}');        // Output: Trực: Thành
  print('Nạp Âm: ${lunar.napAm}');            // Output: Nạp Âm: Phúc Đăng Hỏa
  
  // Check if it's a lucky day
  if (lunar.isHoangDao) {
    print('Ngày Hoàng Đạo (Lucky Day)');
  } else {
    print('Ngày Hắc Đạo (Unlucky Day)');
  }
}
```

### Advanced: Hour Can-Chi Calculation

The package can calculate Can-Chi down to the hour level using the traditional "Ngũ Thử Độn" method:

```dart
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';

void main() {
  // Get Can-Chi for a specific time (e.g., 09:30 AM)
  final DateTime dateTime = DateTime(2025, 11, 28, 9, 30);
  final CanChi hourCanChi = dateTime.hourCanChi;
  
  print('Giờ ${hourCanChi.vnName}'); // Output: Giờ Quý Tỵ
  
  // Or use the extension method for formatted string
  print(dateTime.hourCanChiName);     // Output: Quý Tỵ
}
```

### Feng Shui & Element Analysis

```dart
import 'package:vietnamese_calendar_attributes/vietnamese_calendar_attributes.dart';

void main() {
  final LunarDate lunar = DateTime(2025, 11, 28).lunarDate;
  
  // Get Nap Am (Melodic Element)
  print('Nạp Âm: ${lunar.napAm}'); // e.g., "Phúc Đăng Hỏa"
  
  // Get the Five Elements (Ngũ Hành) of Nap Am
  final NguHanh element = lunar.napAmElement;
  print('Ngũ Hành: ${element.vnName}'); // e.g., "Hỏa"
  
  // Get the element of the Year Stem
  final NguHanh yearElement = lunar.canChiNam.can.element;
  print('Ngũ Hành của Can năm: ${yearElement.vnName}');
}
```

## 📚 API Reference

### Extension Methods on `LunarDate`

The package extends `LunarDate` (from `vietnamese_lunar_core`) with the following properties:

| Property | Type | Description |
|----------|------|-------------|
| `canChiNam` | `CanChi` | Year Can-Chi pair |
| `canChiThang` | `CanChi` | Month Can-Chi pair |
| `canChiNgay` | `CanChi` | Day Can-Chi pair |
| `fullCanChiNam` | `String` | Formatted Year Can-Chi (e.g., "Ất Tỵ") |
| `fullCanChiThang` | `String` | Formatted Month Can-Chi (e.g., "Đinh Hợi") |
| `fullCanChiNgay` | `String` | Formatted Day Can-Chi (e.g., "Tân Sửu") |
| `napAm` | `String` | Nap Am name (e.g., "Phúc Đăng Hỏa") |
| `napAmElement` | `NguHanh` | Five Elements of Nap Am |
| `dayType` | `DayType` | `hoangDao`, `hacDao`, or `normal` |
| `isHoangDao` | `bool` | Whether it's a lucky day |
| `truc` | `Truc` | Day Officer (12-day cycle) |
| `tietKhi` | `SolarTerm` | Solar Term (24 terms) |

### Extension Methods on `DateTime`

| Property | Type | Description |
|----------|------|-------------|
| `lunarDate` | `LunarDate` | Convert solar date to lunar |
| `hourCanChi` | `CanChi` | Hour Can-Chi pair |
| `hourCanChiName` | `String` | Formatted Hour Can-Chi (e.g., "Quý Tỵ") |

### Static Methods in `VnAttributeUtils`

For advanced usage, you can also use static methods directly:

```dart
// Get Can-Chi directly from solar date
final CanChi dayPair = VnAttributeUtils.dayCanChiFromSolar(DateTime(2025, 11, 28));

// Get Hour Can-Chi
final CanChi hourPair = VnAttributeUtils.hourCanChi(DateTime(2025, 11, 28, 9, 30));

// Convert between solar and lunar
final LunarDate lunar = VnAttributeUtils.fromSolar(DateTime(2025, 11, 28));
final DateTime solar = VnAttributeUtils.toSolar(lunar);
```

### Type-Safe Enums

All cultural attributes use strict Enums to ensure type safety:

- **`Can`**: `giap`, `at`, `binh`, `dinh`, `mau`, `ky`, `canh`, `tan`, `nham`, `quy`
- **`Chi`**: `ty`, `suu`, `dan`, `mao`, `thin`, `ty_`, `ngo`, `mui`, `than`, `dau`, `tuat`, `hoi`
- **`NguHanh`**: `kim`, `moc`, `thuy`, `hoa`, `tho`
- **`Truc`**: `kien`, `tru`, `man`, `binh`, `dinh`, `chap`, `pha`, `nguy`, `thanh`, `thu`, `khai`, `be`
- **`SolarTerm`**: `lapXuan`, `vuThuy`, `kinhTrap`, `xuanPhan`, `thanhMinh`, `coVu`, `lapHa`, `tieuMan`, `mangChung`, `haChi`, `tieuThu`, `daiThu`, `lapThu`, `xuThu`, `bachLo`, `thuPhan`, `hanLo`, `suongGiang`, `lapDong`, `tieuTuyet`, `daiTuyet`, `dongChi`, `tieuHan`, `daiHan`
- **`DayType`**: `hoangDao`, `hacDao`, `normal`

Each enum has a `.vnName` extension getter that returns the Vietnamese name:

```dart
print(Can.giap.vnName);      // "Giáp"
print(Chi.ty.vnName);        // "Tý"
print(NguHanh.hoa.vnName);   // "Hỏa"
print(Truc.thanh.vnName);    // "Thành"
print(SolarTerm.lapXuan.vnName); // "Lập Xuân"
```

## 🔬 Algorithm Details

### Ngũ Hổ Độn (Five Tigers Method)

Used for calculating Month Can-Chi:
- Month 1 (Tháng Giêng) always starts with **Dần** (Tiger) as the branch
- The stem depends on the Year Can using a specific mapping table
- Subsequent months follow the natural progression

### Ngũ Thử Độn (Five Rats Method)

Used for calculating Hour Can-Chi:
- Hour 1 (23:00-01:00) always starts with **Tý** (Rat) as the branch
- The stem depends on the Day Can using a specific mapping table
- Hours are divided into 12 two-hour blocks

### Day Can-Chi Calculation

Based on Julian Day Number (JDN) with a known anchor point, ensuring continuity across the 60-day cycle (Lục Thập Hoa Giáp).

## 🧪 Testing

The package includes comprehensive unit tests, including stress tests that validate:
- 24+ hour Can-Chi calculations
- 30+ consecutive day continuity
- 24+ months across multiple years
- 20+ years spanning centuries

Run tests with:

```bash
dart test
```

## 📝 License

[Add your license here]

## 🤝 Contributing

Contributions are welcome! Please ensure all tests pass before submitting a pull request.

## 🔗 Related Packages

- [`vietnamese_lunar_core`](https://github.com/kaovodich/kaovodich_vietnamese_lunar_core): Core lunar calendar conversion library

## 📧 Support

For issues, questions, or contributions, please open an issue on the GitHub repository.

---

**Note**: All output strings (Can-Chi names, Nap Am, etc.) are in Vietnamese. The library API and documentation use English for developer accessibility.
