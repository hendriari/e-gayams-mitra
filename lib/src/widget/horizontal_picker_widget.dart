
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';

/// update 13 12 22
/// mengubah border radius, background warna dan warna border
dynamic horizontalPicker({
  required BuildContext context,
  required ValueNotifier<String> isSelected,
}) {
  AdaptSize.size(context: context);
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: locationOffice.length,
    itemBuilder: ((context, index) {
      return ValueListenableBuilder(
        valueListenable: isSelected,
        builder: ((context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  isSelected.value = locationOffice[index];
                },
                child: Container(
                  height: AdaptSize.screenWidth / 1000 * 300,
                  width: AdaptSize.screenWidth / 1000 * 300,
                  margin: EdgeInsets.all(AdaptSize.pixel8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      opacity: isSelected.value == locationOffice[index] ? .6 : .9,
                      fit: BoxFit.cover,
                      image: const AssetImage(
                          'assets/image/maps.png'),
                    ),
                    color: isSelected.value == locationOffice[index]
                        ? MyColor.warning600
                        : MyColor.neutral700,
                    border: Border.all(
                      color: isSelected.value == locationOffice[index]
                          ? MyColor.warning400
                          : MyColor.neutral900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AdaptSize.pixel10),
                child: Text(
                  locationOffice[index],
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: AdaptSize.screenHeight * 0.016,
                  ),
                ),
              ),
            ],
          );
        }),
      );
    }),
  );
}

List<String> locationOffice = [
  'Kel. Siwalan',
  'Kel. Gayamsari',
  'Kel. Sambirejo',
  'Kel. Pandean Lamper',
  'Kel. Sawah Besar',
  'Kel. Tambakrejo',
  'Kel. Kaligawe',
];
