import 'package:flutter/material.dart';

extension WidgetExtension on int {
  Widget get height => Container(height: toDouble());
  Widget get width => Container(width: toDouble());
}
