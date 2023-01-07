import 'package:flutter/cupertino.dart';

import '../../../../shared/global/app_colors.dart';

Widget MyDivider()=>Padding(
  padding:  EdgeInsets.symmetric(horizontal:20),
  child:   Container
    (
    width: double.infinity,
    height: 2,
    color: AppColors.lightGrey.withOpacity(0.2),
  ),
);