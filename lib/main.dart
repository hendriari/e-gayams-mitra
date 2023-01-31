import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kkn_siwalan_mitra/firebase_options.dart';
import 'package:kkn_siwalan_mitra/src/screen/landing/splash_screen1.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/utils/enums.dart';
import 'package:kkn_siwalan_mitra/src/utils/text_theme.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/menu_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/network_status.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/post_product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const EsiwalanMitra());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class EsiwalanMitra extends StatelessWidget {
  const EsiwalanMitra({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
        ChangeNotifierProvider(create: (_) => LoginRegisterViewModel()),
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        // ChangeNotifierProvider(create: (_) => ProductDummyData()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        // ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => PostProductViewModel()),
        StreamProvider<NetworkStatus>(
          create: (_) => NetworkStatusServices().networkStatusController.stream,
          initialData: NetworkStatus.online,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: MyColor.neutral900,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: MyColor.neutral900,
              ),
          scaffoldBackgroundColor: MyColor.neutral900,
          textTheme: myTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
