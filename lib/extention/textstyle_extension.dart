import 'package:flutter/material.dart';
import 'package:img_gallaries_mini_app/util/app_color.dart';

extension IGMTextstyle on TextTheme {
  TextStyle get black13 => TextStyle(color: AppColor.black);
  TextStyle get black13W600 => black13.copyWith(fontWeight: FontWeight.w600);
  TextStyle get blue17W600 => black13.copyWith(
      fontWeight: FontWeight.w600, fontSize: 17, color: AppColor.blue);
}
