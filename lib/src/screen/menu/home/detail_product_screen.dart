import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/widget/card_shimmer_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/shimmer_loading_widget.dart';

class DetailProductScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const DetailProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.only(
            top: AdaptSize.paddingTop + 10,
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// lead image
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: product['productImage'],
                    imageBuilder: (context, imageProvider) => InkWell(
                      splashColor: MyColor.neutral900,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(
                              left: AdaptSize.pixel8,
                              right: AdaptSize.pixel8,
                            ),
                            child: Image(
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: AdaptSize.screenWidth / 1000 * 800,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: AdaptSize.pixel8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => shimmerLoading(
                      child: cardShimmerWidget(
                        height: AdaptSize.screenWidth / 1000 * 800,
                        width: double.infinity,
                        borderRadius: 16,
                        imagesShimmer: 'logo_kkn_siwalan.png',
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        errorShimmerWidget(
                          height: AdaptSize.screenWidth / 1000 * 800,
                          width: double.infinity,
                          borderRadius: 16,
                          imagesShimmer: 'error.png',
                        ),
                  ),
                  Positioned(
                    left: AdaptSize.pixel8,
                    top: AdaptSize.pixel2,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: MyColor.neutral900,
                        size: AdaptSize.pixel22,
                      ),
                    ),
                  ),
                ],
              ),

              /// grid image
              SizedBox(
                height: AdaptSize.screenWidth / 1000 * 300,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      bottom: AdaptSize.pixel8,
                    ),
                    itemCount: product['productGridImage'].length,
                    scrollDirection: Axis.horizontal,
                    physics: product['productGridImage'].length < 2
                        ? const NeverScrollableScrollPhysics()
                        : const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: product['productGridImage'][index],
                        imageBuilder: (context, imageProvider) => InkWell(
                          splashColor: MyColor.neutral900,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  left: AdaptSize.pixel8,
                                  right: AdaptSize.pixel8,
                                ),
                                child: Image(
                                  image: imageProvider,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: AdaptSize.pixel4,
                                right: AdaptSize.pixel4),
                            // : EdgeInsets.zero,
                            width: AdaptSize.screenWidth / 1000 * 305,
                            decoration: BoxDecoration(
                              color: MyColor.neutral700,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => shimmerLoading(
                          child: cardShimmerWidget(
                            borderRadius: 16,
                            imagesShimmer: 'logo_kkn_siwalan.png',
                            height: AdaptSize.screenWidth / 1000 * 300,
                            width: AdaptSize.screenWidth / 1000 * 305,
                            margin: EdgeInsets.only(
                              left: AdaptSize.pixel4,
                              right: AdaptSize.pixel4,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            errorShimmerWidget(
                              borderRadius: 16,
                              imagesShimmer: 'cancel.png',
                              height: AdaptSize.screenWidth / 1000 * 300,
                              width: AdaptSize.screenWidth / 1000 * 305,
                              margin: EdgeInsets.only(
                                left: AdaptSize.pixel4,
                                right: AdaptSize.pixel4,
                              ),
                            ),
                      );
                    }),
              ),

              /// product name
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product['productName'],
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: AdaptSize.pixel22),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Chip(
                    label: Text(
                      'RW ${product['productRW']}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: AdaptSize.pixel12),
                    ),
                    backgroundColor: MyColor.neutral900,
                    side: BorderSide(color: MyColor.neutral500),
                    //padding: EdgeInsets.zero,
                  ),
                ],
              ),

              /// date published
              Text(
                'Update : ${DateFormat.yMMMd().format(product['datePublished'].toDate())}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: AdaptSize.pixel10,
                  color: MyColor.neutral400,
                ),
                maxLines: 1,
              ),

              SizedBox(
                height: AdaptSize.pixel5,
              ),

              /// seller name
              Row(
                children: [
                  Icon(
                    CupertinoIcons.person_crop_circle_badge_checkmark,
                    size: AdaptSize.pixel20,
                    color: MyColor.info300,
                  ),
                  SizedBox(
                    width: AdaptSize.pixel8,
                  ),
                  Text(
                    product['sellerName'],
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: AdaptSize.pixel12),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              Divider(
                color: MyColor.neutral600,
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// text description
              textTitle(
                context: context,
                text: 'Deskripsi',
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// product description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.doc_text,
                    size: AdaptSize.pixel20,
                    color: MyColor.info300,
                  ),
                  SizedBox(
                    width: AdaptSize.pixel8,
                  ),
                  Expanded(
                    child: Text(
                      product['productDescription'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: AdaptSize.pixel14),
                      textAlign: TextAlign.justify,
                      maxLines: null,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              Divider(
                color: MyColor.neutral600,
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// text manfaat
              textTitle(
                context: context,
                text: 'Manfaat',
              ),

              /// manfaat
              Row(
                children: [
                  Icon(
                    CupertinoIcons.rectangle_on_rectangle_angled,
                    size: AdaptSize.pixel20,
                    color: MyColor.info300,
                  ),
                  SizedBox(
                    width: AdaptSize.pixel10,
                  ),
                  Expanded(
                    child: Text(
                      product['productBenefit'],
                      style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: AdaptSize.pixel14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              Divider(
                color: MyColor.neutral600,
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// text lokasi
              textTitle(
                context: context,
                text: 'Lokasi',
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              ///product location
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: AdaptSize.pixel20,
                    color: MyColor.info300,
                  ),
                  SizedBox(
                    width: AdaptSize.pixel5,
                  ),
                  Expanded(
                    child: Text(
                      product['productLocation'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: AdaptSize.pixel15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              Divider(
                color: MyColor.neutral600,
              ),

              SizedBox(
                height: AdaptSize.pixel8,
              ),

              /// text kategori
              textTitle(
                context: context,
                text: 'Kategori',
              ),

              /// list kategori
              SizedBox(
                height: AdaptSize.screenWidth / 1000 * 110,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: AdaptSize.pixel5),
                    scrollDirection: Axis.horizontal,
                    itemCount: product['productCategory'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: AdaptSize.pixel8),
                        child: Chip(
                          backgroundColor: Color(
                              (math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          label: Text(
                            product['productCategory'][index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontSize: AdaptSize.pixel14,
                              color: MyColor.neutral900,
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              SizedBox(
                height:
                AdaptSize.screenWidth / 1000 * 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// text title
  Widget textTitle({
    required BuildContext context,
    required String text,
  }) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: AdaptSize.pixel16,
      ),
    );
  }
}
