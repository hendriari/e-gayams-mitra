import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/enums.dart';
import 'package:provider/provider.dart';

class NetworkAware extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAware(
      {Key? key, required this.onlineChild, required this.offlineChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(builder: (context, value, child) {
      return value == NetworkStatus.online ? onlineChild : offlineChild;
    });
  }
}
