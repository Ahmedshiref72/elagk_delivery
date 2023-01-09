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
import '../../../shared/utils/app_bar_icon.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/navigation.dart';
import '../components/orderContent.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
                appBar: homePageAppBar(
                  title: AppBarTitle(text: AppStrings.orders,),
                  onTap: () {
                      navigateTo(
                      context: context,
                      screenRoute: Routes.notification,
                    );
                  },
                  actionWidget: AppBarIcon(),
                  context,
                ),
                body:OrdersContents()
            ),
            // HomeScreen
          ),
        );
      },
    );
  }
}
