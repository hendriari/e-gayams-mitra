import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoading({
  required Widget child,
}) {
  return Shimmer.fromColors(
    baseColor: MyColor.neutral600,
    highlightColor: MyColor.neutral900,
    child: child,
  );
}
