import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdaptSize.size(context: context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AdaptSize.paddingTop,
          left: AdaptSize.screenWidth * .016,
          right: AdaptSize.screenWidth * .016,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/network.png'),
              SizedBox(
                height: AdaptSize.screenHeight * .018,
              ),
              Text(
                'No Internet Issues',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: AdaptSize.pixel15),
              ),
              SizedBox(
                height: AdaptSize.screenHeight * .016,
              ),
              Text(
                'Internet connection not detected, but don\'t worry, we understand that! Please check your internet network, we will detect it automatically',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: AdaptSize.pixel14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
