import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan_mitra/src/widget/shimmer_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget productCardWidget({
  required BuildContext context,
  required Map<String, dynamic> product,
  Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    splashColor: MyColor.neutral900,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      height: AdaptSize.screenWidth / 1000 * 825,
      width: double.infinity,
      margin: EdgeInsets.all(AdaptSize.pixel8),
      padding: EdgeInsets.all(AdaptSize.pixel8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyColor.neutral900,
        boxShadow: [
          BoxShadow(
            color: MyColor.neutral400,
            blurRadius: 4,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// product name & option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// product name
              Expanded(
                child: Text(
                  product['productName'],
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: AdaptSize.pixel16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// option
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  CustomDialogs().customDialog(
                    context: context,
                    image: 'notfound',
                    title: 'Hapus Produk ?',
                    textButton1: 'Hapus',
                    textButton2: '',
                    singleButton: true,
                    singleOnpressed: () {
                      /// button delete product
                      CustomDialogs().customDialog(
                        context: context,
                        image: 'error',
                        title: 'Yakin hapus produk ini ?',
                        textButton1: 'Batal',
                        textButton2: 'Hapus',
                        onPress1: () {
                          Navigator.pop(context);
                        },
                        onPress2: () async {
                          context.read<ProductViewModel>().deleteProductById(
                                context: context,
                                productId: product['productId'],
                              );
                        },
                        bgButton1: MyColor.danger400,
                        bgButton2: MyColor.neutral900,
                      );
                    },
                    bgSingleButton: MyColor.danger400,
                    bgButton2: MyColor.neutral900,
                  );
                },
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: AdaptSize.pixel20,
                ),
              ),
            ],
          ),

          CachedNetworkImage(
            imageUrl: product['productImage'],
            imageBuilder: (_, imageProvider) => SizedBox(
              height: AdaptSize.screenWidth / 1000 * 500,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => shimmerLoading(
              child: cardShimmerWidget(
                height: AdaptSize.screenWidth / 1000 * 500,
                width: double.infinity,
                borderRadius: 16,
                imagesShimmer: 'logo_kkn.png',
              ),
            ),
            errorWidget: (context, url, error) => errorShimmerWidget(
              borderRadius: 16,
              height: AdaptSize.screenWidth / 1000 * 500,
              width: double.infinity,
              imagesShimmer: 'error.png',
            ),
          ),

          SizedBox(
            height: AdaptSize.pixel14,
          ),

          Text(
            product['productPrice'],
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: AdaptSize.pixel14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(
            height: AdaptSize.pixel8,
          ),

          /// date published
          Text(
            'update at : ${DateFormat.yMMMd().format(product['datePublished'].toDate())}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: AdaptSize.pixel10,
                  color: MyColor.neutral400,
                ),
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}
