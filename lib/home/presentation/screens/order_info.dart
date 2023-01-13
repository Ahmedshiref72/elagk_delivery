import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/home/data/models/orders_model.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/second_appBar.dart';
import '../../../shared/utils/app_bar_icon.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/navigation.dart';
import '../components/orderInfoContent.dart';


class OrderInformation extends StatelessWidget {

   OrderInformation({Key? key, this.Order}) : super(key: key);
   final OrdersModel? Order;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar:  SecondAppBar(
              context: context,
              title:'الطلب رقم '+ Order!.orderId.toString(),
              onTap: () {
                navigateTo(
                  context: context,
                  screenRoute: Routes.notification,
                );
              },
              actionWidget:AppBarIcon(),
            ),
            body:
            ScreenBackground(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children:  [
                   OrderInformationContent(Order: Order,),
                    ],
                  ),
                ),
              ),
            ),

        ),
        // HomeScreen
      ),
    );
  }
}
