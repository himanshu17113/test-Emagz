import 'dart:math';

class Colorfiltergenerator {
  static List<double> hueadjustmatrix({double? value = 0}) {
    if (value == 0) {
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];
    } else {
      value = value! * pi;
    }

    double cosval = cos(value);
    double sinval = sin(value);
    double lumr = 0.213;
    double lumg = 0.715;
    double lumb = 0.072;

    return List<double>.from(<double>[
      (lumr + (cosval * (1 - lumr))) + (sinval * (-lumr)),
      (lumg + (cosval * (-lumg))) + (sinval * (-lumg)),
      (lumb + (cosval * (-lumb))) + (sinval * (1 - lumb)),
      0,
      0,
      (lumr + (cosval * (-lumr))) + (sinval * 0.143),
      (lumg + (cosval * (1 - lumg))) + (sinval * 0.14),
      (lumb + (cosval * (-lumb))) + (sinval * (-0.283)),
      0,
      0,
      (lumr + (cosval * (-lumr))) + (sinval * (-(1 - lumr))),
      (lumg + (cosval * (-lumg))) + (sinval * lumg),
      (lumb + (cosval * (1 - lumb))) + (sinval * lumb),
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }

  static List<double> brightnessadjustmatrix({double value = 1}) {
    if (value <= 0) {
      value = value * 255;
    } else {
      value = value * 100;
    }

    if (value == 0) {
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];
    }

    return List<double>.from(<double>[
      1,
      0,
      0,
      0,
      value,
      0,
      1,
      0,
      0,
      value,
      0,
      0,
      1,
      0,
      value,
      0,
      0,
      0,
      1,
      0
    ]).map((i) => i.toDouble()).toList();
  }

  static List<double> saturationadjustmatrix({double? value = 0}) {
    if (value == 0) {
      return [
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ];
    } else {
      value = value! * 100;
    }

    double x =
        ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();
    double lumr = 0.3086;
    double lumg = 0.6094;
    double lumb = 0.082;

    return List<double>.from(<double>[
      (lumr * (1 - x)) + x,
      lumg * (1 - x),
      lumb * (1 - x),
      0,
      0,
      lumr * (1 - x),
      (lumg * (1 - x)) + x,
      lumb * (1 - x),
      0,
      0,
      lumr * (1 - x),
      lumg * (1 - x),
      (lumb * (1 - x)) + x,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]).map((i) => i.toDouble()).toList();
  }
}
