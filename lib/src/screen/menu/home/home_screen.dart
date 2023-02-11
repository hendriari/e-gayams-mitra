import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan_mitra/src/screen/menu/home/detail_product_screen.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/default_appbar.dart';
import 'package:kkn_siwalan_mitra/src/widget/product_card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().refreshUsers();
    context.read<ProductViewModel>().getProduct;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductViewModel>(context, listen: false);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'My Product',
        action: [
          IconButton(
            onPressed: () {
              NavigasiViewModel().navigateAddProduct(context);
            },
            icon: Icon(
              CupertinoIcons.add,
              color: Colors.black,
              size: AdaptSize.pixel20,
            ),
          )
        ],
      ),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: StreamBuilder(
          stream: productProvider.getProduct,
          builder:
              (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColor.warning600,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada produk',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: AdaptSize.pixel14,
                      ),
                ),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.only(
                    bottom: AdaptSize.screenWidth / 1000 * 250,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return productCardWidget(
                        context: context,
                        product: snapshot.data!.docs[index].data(),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DetailProductScreen(
                                product: snapshot.data!.docs[index].data(),
                              ),
                            ),
                          );
                        });
                  });
            }
            return Center(
              child: Text(
                'loading..',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: AdaptSize.pixel14,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
