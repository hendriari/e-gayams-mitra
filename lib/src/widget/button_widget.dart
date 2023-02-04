import 'package:flutter/material.dart';

Widget buttonWidget({
  Function()? onPressed,
  double? sizeHeight,
  double? sizeWidth,
  double? elevation,
  BorderSide? side,
  EdgeInsetsGeometry? margin,
  Color? backgroundColor,
  Color? foregroundColor,
  Widget? child,
  double? borderRadius,
  EdgeInsetsGeometry? padding,
}) {
  return Container(
    height: sizeHeight,
    width: sizeWidth,
    margin: margin,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        side: side,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: child,
    ),
  );
}
