import 'package:flutter/cupertino.dart';

double? height;
double? width;

extension DeviceSize on BuildContext {
  double deviceHeight() {
    height = MediaQuery.of(this).size.height;
    return  height!;
  }

  double deviceWidth() {
    width =  MediaQuery.of(this).size.width;
    return  width!;
  }
}

const String apikey = "2d2118c3873e4f06b8ebe3d02ab35cf2";
