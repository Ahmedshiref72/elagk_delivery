
import 'package:elagk_delivery/shared/utils/app_routes.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';

class PointsProductsBar extends StatelessWidget {
  const PointsProductsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Row(
        children: const [
          Text(
            AppStrings.pointsForReplace,
            style: TextStyle(
              fontSize: 17,
                fontWeight: FontWeight.bold),
          ),


        ],
      ),
    );
  }
}
