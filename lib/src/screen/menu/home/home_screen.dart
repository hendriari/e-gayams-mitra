import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/default_appbar.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
        onlineChild: Center(
          child: Text(
            'Belum ada Produk',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: AdaptSize.pixel14),
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   padding: EdgeInsets.only(
      //     left: AdaptSize.pixel8,
      //     right: AdaptSize.pixel8,
      //     top: AdaptSize.pixel10,
      //     bottom: AdaptSize.screenWidth / 1000 * 250,
      //   ),
      //   child: Text('Belum Ada Postingan'),
      // ),
    );
  }
}
