import 'package:elagk_delivery/home/presentation/components/search_widget.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/na_data_widget.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_strings.dart';
import '../../../shared/utils/app_values.dart';
import '../controllers/home_screen_controller/home_screen_state.dart';
import 'orders_components/my_devider_component.dart';
import 'orders_components/order_item_content.dart';

class OrdersContents extends StatelessWidget {
  const OrdersContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (HomeScreenCubit.get(context).Orders.isNotEmpty ) {
          return Column(
            children: [

              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: ()async
                  {
                    HomeScreenCubit.get(context).getOrders();
                  },
                  child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => OrderItem(
                          context: context,
                          ordersModel: HomeScreenCubit.get(context).Orders[index]),
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: HomeScreenCubit.get(context).Orders.length),
                ),
              ),
            ],
          );
        }else if(HomeScreenCubit.get(context).Orders.isEmpty)
        {
          return Center(child: NoDataWidget(AppStrings.noOrders));
        }
        else
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
      },
    );
  }
}