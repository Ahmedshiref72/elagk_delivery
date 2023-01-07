import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/home/presentation/components/app_bar_title.dart';
import 'package:elagk_delivery/home/presentation/components/home_app_bar.dart';
import 'package:elagk_delivery/home/presentation/components/orders_components/order_item_content.dart';
import 'package:elagk_delivery/home/presentation/components/search_widget.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/components/orders_components/my_devider_component.dart';
import '../components/notificationAppBar.dart';
import '../components/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar: NotificationPageAppBar(
              title: AppBarTitle(text: AppStrings.notifications,),
              onTap: () {

              },
              context,
            ),
            body:
            ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p15),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: mediaQueryHeight(context) * .025,
                      ),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index)
                          {
                            return NotificationItem(orderTime: '12 مساء', onTap: () {  }, orderNumber: '12',);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 20,),
                          itemCount:25
                      )

                    ],
                  ),
                ),
              ),
            )),
        // NotificationScreen
      ),
    );
  }
}
