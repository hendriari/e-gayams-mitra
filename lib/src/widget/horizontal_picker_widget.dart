import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';

dynamic horizontalPicker({
  required BuildContext context,
  required ValueNotifier<String> isSelected,
  required List listPicker,
  List? imageListPicker,
  double? heightContainer,
  double? widthContainer,
  TextAlign? textAlign,
  TextOverflow? textOverflow,
  int? textMaxLines,
}) {
  AdaptSize.size(context: context);
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: listPicker.length,
    itemBuilder: ((context, index) {
      return ValueListenableBuilder(
        valueListenable: isSelected,
        builder: ((context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  isSelected.value = listPicker[index];
                },
                child: Container(
                  height: heightContainer ?? AdaptSize.screenWidth / 1000 * 300,
                  width: widthContainer ?? AdaptSize.screenWidth / 1000 * 300,
                  margin: EdgeInsets.all(AdaptSize.pixel8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      opacity: isSelected.value == listPicker[index] ? .6 : .9,
                      fit: BoxFit.contain,
                      image: AssetImage(
                          imageListPicker?[index] ?? 'assets/image/maps.png'),
                    ),
                    color: isSelected.value == listPicker[index]
                        ? MyColor.warning600
                        : MyColor.neutral700,
                    border: Border.all(
                      color: isSelected.value == listPicker[index]
                          ? MyColor.warning400
                          : MyColor.neutral900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AdaptSize.pixel10),
                child: Text(
                  listPicker[index],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: AdaptSize.screenHeight * 0.016,
                      ),
                  textAlign: textAlign,
                  overflow: textOverflow,
                  maxLines: textMaxLines,
                ),
              ),
            ],
          );
        }),
      );
    }),
  );
}
