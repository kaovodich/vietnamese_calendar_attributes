library vietnamese_calendar_attributes;

import 'dart:math' as math;

import 'package:vietnamese_lunar_core/vietnamese_lunar_core.dart';

enum Can { giap, at, binh, dinh, mau, ky, canh, tan, nham, quy }

extension CanExt on Can {
  String get vnName {
    switch (this) {
      case Can.giap:
        return 'Giáp';
      case Can.at:
        return 'Ất';
      case Can.binh:
        return 'Bính';
      case Can.dinh:
        return 'Đinh';
      case Can.mau:
        return 'Mậu';
      case Can.ky:
        return 'Kỷ';
      case Can.canh:
        return 'Canh';
      case Can.tan:
        return 'Tân';
      case Can.nham:
        return 'Nhâm';
      case Can.quy:
        return 'Quý';
    }
  }

  NguHanh get element {
    switch (this) {
      case Can.giap:
      case Can.at:
        return NguHanh.moc;
      case Can.binh:
      case Can.dinh:
        return NguHanh.hoa;
      case Can.mau:
      case Can.ky:
        return NguHanh.tho;
      case Can.canh:
      case Can.tan:
        return NguHanh.kim;
      case Can.nham:
      case Can.quy:
        return NguHanh.thuy;
    }
  }
}

enum Chi { ty, suu, dan, mao, thin, ty_, ngo, mui, than, dau, tuat, hoi }

extension ChiExt on Chi {
  String get vnName {
    switch (this) {
      case Chi.ty:
        return 'Tý';
      case Chi.suu:
        return 'Sửu';
      case Chi.dan:
        return 'Dần';
      case Chi.mao:
        return 'Mão';
      case Chi.thin:
        return 'Thìn';
      case Chi.ty_:
        return 'Tỵ';
      case Chi.ngo:
        return 'Ngọ';
      case Chi.mui:
        return 'Mùi';
      case Chi.than:
        return 'Thân';
      case Chi.dau:
        return 'Dậu';
      case Chi.tuat:
        return 'Tuất';
      case Chi.hoi:
        return 'Hợi';
    }
  }
}

enum NguHanh { kim, moc, thuy, hoa, tho }

extension NguHanhExt on NguHanh {
  String get vnName {
    switch (this) {
      case NguHanh.kim:
        return 'Kim';
      case NguHanh.moc:
        return 'Mộc';
      case NguHanh.thuy:
        return 'Thủy';
      case NguHanh.hoa:
        return 'Hỏa';
      case NguHanh.tho:
        return 'Thổ';
    }
  }
}

enum Truc {
  kien,
  tru,
  man,
  binh,
  dinh,
  chap,
  pha,
  nguy,
  thanh,
  thu,
  khai,
  be,
}

extension TrucExt on Truc {
  String get vnName {
    switch (this) {
      case Truc.kien:
        return 'Kiến';
      case Truc.tru:
        return 'Trừ';
      case Truc.man:
        return 'Mãn';
      case Truc.binh:
        return 'Bình';
      case Truc.dinh:
        return 'Định';
      case Truc.chap:
        return 'Chấp';
      case Truc.pha:
        return 'Phá';
      case Truc.nguy:
        return 'Nguy';
      case Truc.thanh:
        return 'Thành';
      case Truc.thu:
        return 'Thu';
      case Truc.khai:
        return 'Khai';
      case Truc.be:
        return 'Bế';
    }
  }
}

enum DayType { hoangDao, hacDao, normal }

extension DayTypeExt on DayType {
  String get vnName {
    switch (this) {
      case DayType.hoangDao:
        return 'Hoàng đạo';
      case DayType.hacDao:
        return 'Hắc đạo';
      case DayType.normal:
        return 'Thường';
    }
  }
}

enum SolarTerm {
  lapXuan,
  vuThuy,
  kinhTrap,
  xuanPhan,
  thanhMinh,
  coVu,
  lapHa,
  tieuMan,
  mangChung,
  haChi,
  tieuThu,
  daiThu,
  lapThu,
  xuThu,
  bachLo,
  thuPhan,
  hanLo,
  suongGiang,
  lapDong,
  tieuTuyet,
  daiTuyet,
  dongChi,
  tieuHan,
  daiHan,
}

extension SolarTermExt on SolarTerm {
  String get vnName {
    switch (this) {
      case SolarTerm.lapXuan:
        return 'Lập Xuân';
      case SolarTerm.vuThuy:
        return 'Vũ Thủy';
      case SolarTerm.kinhTrap:
        return 'Kinh Trập';
      case SolarTerm.xuanPhan:
        return 'Xuân Phân';
      case SolarTerm.thanhMinh:
        return 'Thanh Minh';
      case SolarTerm.coVu:
        return 'Cốc Vũ';
      case SolarTerm.lapHa:
        return 'Lập Hạ';
      case SolarTerm.tieuMan:
        return 'Tiểu Mãn';
      case SolarTerm.mangChung:
        return 'Mang Chủng';
      case SolarTerm.haChi:
        return 'Hạ Chí';
      case SolarTerm.tieuThu:
        return 'Tiểu Thử';
      case SolarTerm.daiThu:
        return 'Đại Thử';
      case SolarTerm.lapThu:
        return 'Lập Thu';
      case SolarTerm.xuThu:
        return 'Xử Thử';
      case SolarTerm.bachLo:
        return 'Bạch Lộ';
      case SolarTerm.thuPhan:
        return 'Thu Phân';
      case SolarTerm.hanLo:
        return 'Hàn Lộ';
      case SolarTerm.suongGiang:
        return 'Sương Giáng';
      case SolarTerm.lapDong:
        return 'Lập Đông';
      case SolarTerm.tieuTuyet:
        return 'Tiểu Tuyết';
      case SolarTerm.daiTuyet:
        return 'Đại Tuyết';
      case SolarTerm.dongChi:
        return 'Đông Chí';
      case SolarTerm.tieuHan:
        return 'Tiểu Hàn';
      case SolarTerm.daiHan:
        return 'Đại Hàn';
    }
  }
}

class CanChi {
  const CanChi(this.can, this.chi);

  final Can can;
  final Chi chi;

  String get vnName => '${can.vnName} ${chi.vnName}';

  @override
  bool operator ==(Object other) =>
      other is CanChi && other.can == can && other.chi == chi;

  @override
  int get hashCode => Object.hash(can, chi);
}

class _AstronomyUtils {
  const _AstronomyUtils();

  static const double _timeZone = 7.0;

  int julianDayNumber(DateTime date) {
    final int day = date.day;
    final int month = date.month;
    final int year = date.year;
    final int a = ((14 - month) / 12).floor();
    final int y = year + 4800 - a;
    final int m = month + 12 * a - 3;
    int jd = day +
        ((153 * m + 2) / 5).floor() +
        365 * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;
    if (jd < 2299161) {
      jd =
          day + ((153 * m + 2) / 5).floor() + 365 * y + (y / 4).floor() - 32083;
    }
    return jd;
  }

  double _sunLongitude(double jdn) {
    final double t = (jdn - 2451545.0) / 36525;
    final double t2 = t * t;
    final double dr = math.pi / 180;
    double m =
        357.52910 + 35999.05030 * t - 0.0001559 * t2 - 0.00000048 * t * t2;
    double l0 = 280.46645 + 36000.76983 * t + 0.0003032 * t2;
    double dl = (1.914600 - 0.004817 * t - 0.000014 * t2) * math.sin(dr * m);
    dl += (0.019993 - 0.000101 * t) * math.sin(dr * 2 * m);
    dl += 0.000290 * math.sin(dr * 3 * m);
    double l = (l0 + dl) * dr;
    l = l - 2 * math.pi * (l / (2 * math.pi)).floor();
    return l;
  }

  double sunLongitudeRadians(DateTime date) {
    final double jdn = julianDayNumber(date).toDouble();
    return _sunLongitude(jdn - 0.5 - _timeZone / 24);
  }

  SolarTerm solarTerm(DateTime date) {
    final double lon = sunLongitudeRadians(date);
    final int index =
        ((lon / (math.pi / 12)).floor()) % SolarTerm.values.length;
    return SolarTerm.values[index];
  }
}

class VnAttributeUtils {
  const VnAttributeUtils._();

  static const VnLunarCore _core = VnLunarCore();
  static const _AstronomyUtils _astro = _AstronomyUtils();

  static final List<CanChi> _sexagenaryCycle =
      List<CanChi>.unmodifiable(List<CanChi>.generate(
    60,
    (int index) => CanChi(
      Can.values[index % Can.values.length],
      Chi.values[index % Chi.values.length],
    ),
  ));

  static final Map<int, String> _napAmByIndex = Map<int, String>.unmodifiable({
    0: 'Hải Trung Kim',
    1: 'Hải Trung Kim',
    2: 'Lư Trung Hỏa',
    3: 'Lư Trung Hỏa',
    4: 'Đại Lâm Mộc',
    5: 'Đại Lâm Mộc',
    6: 'Lộ Bàng Thổ',
    7: 'Lộ Bàng Thổ',
    8: 'Kiếm Phong Kim',
    9: 'Kiếm Phong Kim',
    10: 'Sơn Đầu Hỏa',
    11: 'Sơn Đầu Hỏa',
    12: 'Giản Hạ Thủy',
    13: 'Giản Hạ Thủy',
    14: 'Thành Đầu Thổ',
    15: 'Thành Đầu Thổ',
    16: 'Bạch Lạp Kim',
    17: 'Bạch Lạp Kim',
    18: 'Dương Liễu Mộc',
    19: 'Dương Liễu Mộc',
    20: 'Tuyền Trung Thủy',
    21: 'Tuyền Trung Thủy',
    22: 'Ốc Thượng Thổ',
    23: 'Ốc Thượng Thổ',
    24: 'Tích Lịch Hỏa',
    25: 'Tích Lịch Hỏa',
    26: 'Tùng Bách Mộc',
    27: 'Tùng Bách Mộc',
    28: 'Trường Lưu Thủy',
    29: 'Trường Lưu Thủy',
    30: 'Sa Trung Kim',
    31: 'Sa Trung Kim',
    32: 'Sơn Hạ Hỏa',
    33: 'Sơn Hạ Hỏa',
    34: 'Bình Địa Mộc',
    35: 'Bình Địa Mộc',
    36: 'Bích Thượng Thổ',
    37: 'Bích Thượng Thổ',
    38: 'Kim Bạch Kim',
    39: 'Kim Bạch Kim',
    40: 'Phúc Đăng Hỏa',
    41: 'Phúc Đăng Hỏa',
    42: 'Thiên Hà Thủy',
    43: 'Thiên Hà Thủy',
    44: 'Đại Dịch Thổ',
    45: 'Đại Dịch Thổ',
    46: 'Thoa Xuyến Kim',
    47: 'Thoa Xuyến Kim',
    48: 'Tang Đố Mộc',
    49: 'Tang Đố Mộc',
    50: 'Đại Khê Thủy',
    51: 'Đại Khê Thủy',
    52: 'Sa Trung Thổ',
    53: 'Sa Trung Thổ',
    54: 'Thiên Thượng Hỏa',
    55: 'Thiên Thượng Hỏa',
    56: 'Thạch Lựu Mộc',
    57: 'Thạch Lựu Mộc',
    58: 'Đại Hải Thủy',
    59: 'Đại Hải Thủy',
  });

  static final Map<int, NguHanh> _napAmElementByIndex =
      Map<int, NguHanh>.unmodifiable({
    0: NguHanh.kim,
    1: NguHanh.kim,
    2: NguHanh.hoa,
    3: NguHanh.hoa,
    4: NguHanh.moc,
    5: NguHanh.moc,
    6: NguHanh.tho,
    7: NguHanh.tho,
    8: NguHanh.kim,
    9: NguHanh.kim,
    10: NguHanh.hoa,
    11: NguHanh.hoa,
    12: NguHanh.thuy,
    13: NguHanh.thuy,
    14: NguHanh.tho,
    15: NguHanh.tho,
    16: NguHanh.kim,
    17: NguHanh.kim,
    18: NguHanh.moc,
    19: NguHanh.moc,
    20: NguHanh.thuy,
    21: NguHanh.thuy,
    22: NguHanh.tho,
    23: NguHanh.tho,
    24: NguHanh.hoa,
    25: NguHanh.hoa,
    26: NguHanh.moc,
    27: NguHanh.moc,
    28: NguHanh.thuy,
    29: NguHanh.thuy,
    30: NguHanh.kim,
    31: NguHanh.kim,
    32: NguHanh.hoa,
    33: NguHanh.hoa,
    34: NguHanh.moc,
    35: NguHanh.moc,
    36: NguHanh.tho,
    37: NguHanh.tho,
    38: NguHanh.kim,
    39: NguHanh.kim,
    40: NguHanh.hoa,
    41: NguHanh.hoa,
    42: NguHanh.thuy,
    43: NguHanh.thuy,
    44: NguHanh.tho,
    45: NguHanh.tho,
    46: NguHanh.kim,
    47: NguHanh.kim,
    48: NguHanh.moc,
    49: NguHanh.moc,
    50: NguHanh.thuy,
    51: NguHanh.thuy,
    52: NguHanh.tho,
    53: NguHanh.tho,
    54: NguHanh.hoa,
    55: NguHanh.hoa,
    56: NguHanh.moc,
    57: NguHanh.moc,
    58: NguHanh.thuy,
    59: NguHanh.thuy,
  });

  static final Map<Can, Can> _tigerMethodStarts =
      Map<Can, Can>.unmodifiable(<Can, Can>{
    Can.giap: Can.binh,
    Can.ky: Can.binh,
    Can.at: Can.mau,
    Can.canh: Can.mau,
    Can.binh: Can.canh,
    Can.tan: Can.canh,
    Can.dinh: Can.nham,
    Can.nham: Can.nham,
    Can.mau: Can.giap,
    Can.quy: Can.giap,
  });

  static final Map<Can, Can> _ratMethodStarts =
      Map<Can, Can>.unmodifiable(<Can, Can>{
    Can.giap: Can.giap,
    Can.ky: Can.giap,
    Can.at: Can.binh,
    Can.canh: Can.binh,
    Can.binh: Can.mau,
    Can.tan: Can.mau,
    Can.dinh: Can.canh,
    Can.nham: Can.canh,
    Can.mau: Can.nham,
    Can.quy: Can.nham,
  });

  static final Map<Chi, Set<Chi>> _hoangDaoTable =
      Map<Chi, Set<Chi>>.unmodifiable({
    Chi.dan: <Chi>{Chi.dan, Chi.mao, Chi.ty_, Chi.than, Chi.tuat, Chi.hoi},
    Chi.mao: <Chi>{Chi.thin, Chi.ty_, Chi.mui, Chi.tuat, Chi.hoi, Chi.suu},
    Chi.thin: <Chi>{Chi.ty, Chi.suu, Chi.mao, Chi.ngo, Chi.mui, Chi.dau},
    Chi.ty_: <Chi>{Chi.ty, Chi.dan, Chi.mao, Chi.ngo, Chi.than, Chi.dau},
    Chi.ngo: <Chi>{Chi.dan, Chi.thin, Chi.ty_, Chi.than, Chi.tuat, Chi.hoi},
    Chi.mui: <Chi>{Chi.dan, Chi.mao, Chi.ty_, Chi.than, Chi.tuat, Chi.hoi},
    Chi.than: <Chi>{Chi.thin, Chi.ty_, Chi.mui, Chi.tuat, Chi.hoi, Chi.suu},
    Chi.dau: <Chi>{Chi.ty, Chi.suu, Chi.mao, Chi.ngo, Chi.mui, Chi.dau},
    Chi.tuat: <Chi>{Chi.ty, Chi.dan, Chi.mao, Chi.ngo, Chi.than, Chi.dau},
    Chi.hoi: <Chi>{Chi.dan, Chi.thin, Chi.ty_, Chi.than, Chi.tuat, Chi.hoi},
    Chi.ty: <Chi>{Chi.thin, Chi.ty_, Chi.mui, Chi.tuat, Chi.hoi, Chi.suu},
    Chi.suu: <Chi>{Chi.ty, Chi.suu, Chi.mao, Chi.ngo, Chi.mui, Chi.dau},
  });

  static LunarDate fromSolar(DateTime date) => _core.convertSolarToLunar(date);

  static DateTime toSolar(LunarDate lunar) => _core.convertLunarToSolar(
        lunar.day,
        lunar.month,
        lunar.year,
        lunar.isLeap,
      );

  static CanChi yearCanChi(LunarDate lunar) {
    final Can can = Can.values[(lunar.year + 6) % Can.values.length];
    final Chi chi = Chi.values[(lunar.year + 8) % Chi.values.length];
    return CanChi(can, chi);
  }

  static CanChi monthCanChi(LunarDate lunar) {
    final CanChi yearPair = yearCanChi(lunar);
    final Can startCan = _tigerMethodStarts[yearPair.can]!;
    final int monthOffset = (lunar.month - 1) % Chi.values.length;
    final int canIndex = (startCan.index + monthOffset) % Can.values.length;
    final int chiIndex = (Chi.dan.index + monthOffset) % Chi.values.length;
    return CanChi(Can.values[canIndex], Chi.values[chiIndex]);
  }

  static CanChi dayCanChiFromSolar(DateTime solarDate) {
    final int jdn = _astro.julianDayNumber(solarDate);
    return _canChiFromJdn(jdn);
  }

  static CanChi dayCanChi(LunarDate lunar) =>
      dayCanChiFromSolar(toSolar(lunar));

  static CanChi hourCanChi(DateTime dateTime) {
    final CanChi dayPair = dayCanChiFromSolar(dateTime);
    final int hourIndex = _hourBranchIndex(dateTime);
    final Chi hourChi = Chi.values[hourIndex];
    final Can startCan = _ratMethodStarts[dayPair.can]!;
    final Can hourCan =
        Can.values[(startCan.index + hourIndex) % Can.values.length];
    return CanChi(hourCan, hourChi);
  }

  static DayType dayType(LunarDate lunar) {
    final Chi monthChi = monthCanChi(lunar).chi;
    final Chi dayChi = dayCanChi(lunar).chi;
    final Set<Chi>? hoangDaos = _hoangDaoTable[monthChi];
    if (hoangDaos == null) {
      return DayType.normal;
    }
    return hoangDaos.contains(dayChi) ? DayType.hoangDao : DayType.hacDao;
  }

  static Truc trucNgay(LunarDate lunar) {
    final Chi monthChi = monthCanChi(lunar).chi;
    final Chi dayChi = dayCanChi(lunar).chi;
    final int diff = (dayChi.index - monthChi.index) % Truc.values.length;
    return Truc.values[diff];
  }

  static SolarTerm tietKhi(LunarDate lunar) => _astro.solarTerm(toSolar(lunar));

  static String napAm(LunarDate lunar) {
    final int index = _cycleIndex(yearCanChi(lunar));
    return _napAmByIndex[index] ?? '';
  }

  static NguHanh napAmElement(LunarDate lunar) {
    final int index = _cycleIndex(yearCanChi(lunar));
    return _napAmElementByIndex[index] ?? yearCanChi(lunar).can.element;
  }

  static int _cycleIndex(CanChi pair) {
    for (int i = 0; i < _sexagenaryCycle.length; i++) {
      if (_sexagenaryCycle[i] == pair) {
        return i;
      }
    }
    throw StateError('Invalid Can-Chi pair: ${pair.vnName}');
  }

  static CanChi _canChiFromJdn(int jdn) {
    final Can can = Can.values[(jdn + 9) % Can.values.length];
    final Chi chi = Chi.values[(jdn + 1) % Chi.values.length];
    return CanChi(can, chi);
  }

  static int _hourBranchIndex(DateTime dateTime) {
    final int minutes = dateTime.hour * 60 + dateTime.minute;
    final int block = ((minutes + 60) ~/ 120) % Chi.values.length;
    return block;
  }
}

extension AttributeExt on LunarDate {
  CanChi get canChiNam => VnAttributeUtils.yearCanChi(this);

  CanChi get canChiThang => VnAttributeUtils.monthCanChi(this);

  CanChi get canChiNgay => VnAttributeUtils.dayCanChi(this);

  String get fullCanChiNam => canChiNam.vnName;

  String get fullCanChiThang => canChiThang.vnName;

  String get fullCanChiNgay => canChiNgay.vnName;

  String get napAm => VnAttributeUtils.napAm(this);

  NguHanh get napAmElement => VnAttributeUtils.napAmElement(this);

  DayType get dayType => VnAttributeUtils.dayType(this);

  bool get isHoangDao => dayType == DayType.hoangDao;

  Truc get truc => VnAttributeUtils.trucNgay(this);

  SolarTerm get tietKhi => VnAttributeUtils.tietKhi(this);
}

extension SolarDateAttributeExt on DateTime {
  LunarDate get lunarDate => VnAttributeUtils.fromSolar(this);

  CanChi get hourCanChi => VnAttributeUtils.hourCanChi(this);

  String get hourCanChiName => hourCanChi.vnName;
}
