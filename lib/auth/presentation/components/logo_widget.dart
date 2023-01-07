
import 'package:elagk_delivery/shared/utils/app_assets.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.elagkWord,
      height: mediaQueryHeight(context) / AppSize.s4,
      fit: BoxFit.cover,
    );
  }
}
