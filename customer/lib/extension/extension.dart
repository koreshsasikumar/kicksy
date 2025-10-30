import 'package:flutter/material.dart';

extension Extension on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());

  EdgeInsets get padAll => EdgeInsets.all(toDouble());

  EdgeInsets get padH => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get padV => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get padTop => EdgeInsets.only(top: toDouble());

  EdgeInsets get padBottom => EdgeInsets.only(bottom: toDouble());

  EdgeInsets get padLeft => EdgeInsets.only(left: toDouble());

  EdgeInsets get padRight => EdgeInsets.only(right: toDouble());
}
