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
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/navigation.dart';
import '../components/orders_components/my_devider_component.dart';

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
                  actionWidget: Icon(Icons.notifications_none_outlined),
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
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        AppSize.s8,
                                      ),
                                      /*  gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff137e8f),
                                    Color(0xff059053),
                                  ])*/
                                    ),
                                    width: mediaQueryWidth(context),
                                    height: AppSize.s70,
                                    child: Column(
                                      children: [
                                        SearchWidget(),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: mediaQueryHeight(context) * .025,
                                ),
                                ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index)
                                    {
                                      return OrderItem();
                                    },
                                    separatorBuilder: (context, index) => MyDivider(),
                                    itemCount:25
                                )

                               /* ListView.separated(
                                    itemBuilder: (context,index)=> Container(
                                      height: 80,
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Image.asset(
                                                  'assets/images/order/order.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text('الطلب رقم ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold)),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text('"yyyy-MM-dd"',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade500)),
                                                  SizedBox(
                                                    width:
                                                    mediaQueryWidth(context) *
                                                        0.24,
                                                  ),
                                                  Text(' جنيه ',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade500)),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    separatorBuilder:  (context,index)=> MyDivider(),
                                    itemCount: 2)*/
                                // OrdersContents()
                              ],
                            ),
                          ),
                        ),
                      )),
            // HomeScreen
          ),
        );
      },
    );
  }
}
