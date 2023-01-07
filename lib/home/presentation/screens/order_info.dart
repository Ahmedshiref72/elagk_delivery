import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/home/presentation/components/app_bar_title.dart';
import 'package:elagk_delivery/home/presentation/components/home_app_bar.dart';
import 'package:elagk_delivery/home/presentation/components/orders_components/order_item_content.dart';
import 'package:elagk_delivery/home/presentation/components/search_widget.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import '../components/orderInfoContent.dart';
import '../components/orders_components/my_devider_component.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar: homePageAppBar(
              title: AppBarTitle(text: AppStrings.ordersInfo,),
              onTap: () {
                /*  navigateTo(
                      context: context,
                      screenRoute: Routes.notification,
                    );*/
              },
              actionWidget: const Icon(Icons.notifications_none_outlined),
              context,
            ),
            body:
            ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [

                   OrderInformationContent(),
                    ],
                  ),
                ),
              ),
            )),
        // HomeScreen
      ),
    );
  }
}
