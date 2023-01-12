import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/home/presentation/components/app_bar_title.dart';
import 'package:elagk_delivery/home/presentation/components/home_app_bar.dart';
import 'package:elagk_delivery/home/presentation/components/orders_components/order_item_content.dart';
import 'package:elagk_delivery/home/presentation/components/search_widget.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/notification/controller/notification_cubit.dart';
import 'package:elagk_delivery/notification/controller/notification_state.dart';
import 'package:elagk_delivery/notification/data/notification_model.dart';
import 'package:elagk_delivery/shared/components/na_data_widget.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/components/orders_components/my_devider_component.dart';
import '../../shared/components/second_appBar.dart';
import '../../shared/global/app_colors.dart';
import '../components/notificationAppBar.dart';
import '../components/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit,NotificationState>(
      listener: (context,state){},
      builder: (context,state){

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
                appBar: NotificationAppBar(
                  title:  AppStrings.notifications,
                  context: context,
                ),
                body:
                NotificationCubit.get(context).notifications.isNotEmpty?
                ScreenBackground(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p15),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: RefreshIndicator(
                        onRefresh: ()async
                        {
                          NotificationCubit.get(context).getNotifications();
                        },
                        child:

                        Column(
                          children: [
                            SizedBox(
                              height: mediaQueryHeight(context) * .025,
                            ),
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index)
                                {
                                  return
                                    NotificationItem(
                                      orderTime: NotificationCubit.get(context).notifications[index].createdAt.toString(),
                                      onTap: () {  },
                                      orderNumber: NotificationCubit.get(context).notifications[index].notifiactionId.toString(),
                                    );
                                },
                                separatorBuilder: (context, index) => SizedBox(height: 20,),
                                itemCount:NotificationCubit.get(context).notifications.length
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ):
                (NotificationCubit.get(context).notifications.isEmpty&& state is GetNotificationSuccessState)?
                Center(child: NoDataWidget(AppStrings.noNotificationsYet)):
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
               floatingActionButton: FloatingActionButton(
                onPressed: () {
                  NotificationCubit.get(context).getNotifications();  },
            backgroundColor: AppColors.primary,
                child: Icon(Icons.refresh),
            ),       // NotificationScreen
          ),
        )
        );
      },
    );
  }
}
