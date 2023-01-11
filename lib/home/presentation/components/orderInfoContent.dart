import 'package:dotted_line/dotted_line.dart';
import 'package:elagk_delivery/home/data/models/accepted_model.dart';
import 'package:elagk_delivery/home/presentation/components/scound_button.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_state.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../drawer/presentation/components/contact_us_components/contactus_container_widget.dart';
import '../../../drawer/presentation/controller/contact_us_controller/contact_us_cubit.dart';
import '../../../shared/components/alert_dialoge.dart';
import '../../../shared/components/toast_component.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/app_strings.dart';
import '../../../shared/utils/app_values.dart';
import '../../data/models/orders_model.dart';
import '../controllers/home_screen_controller/home_screen_cubit.dart';
import 'orders_components/orderBasketContent.dart';

class OrderInformationContent extends StatelessWidget {
  OrderInformationContent({
    Key? key,
    this.Order,
  }) : super(key: key);
  final OrdersModel? Order;

  // final CartViews? cartViews;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.deliverTo,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  ContactUsCubit.get(context).openMap(
                      Order!.destinationLatitude!.toDouble(),
                      Order!.destinationLongitude!.toDouble());
                },
                child: Container(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.offWhite,
                      width: AppSize.s1,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.s15),
                  ),
                  child: Icon(Icons.my_location),
                ),
              ),
            ],
          ),
          Text(
            Order!.address.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          //pharmacy name
          Row(
            children: [
              Image.asset(
                'assets/images/drawer_icons/phamacy.png',
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.pharmacyName,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          Text(
            'Order.pharmacyId',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/login/boss(1).png',
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.clientName,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: mediaQueryWidth(context) / 3,
              ),
              Text(
                Order!.delivery!.firstName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                Order!.delivery!.lastName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          InkWell(
            onTap: () {
              launch("tel:${Order!.delivery!.phones}");
            },
            child: ContactUsContainer(
              title: AppStrings.phoneNumber,
              imageSrc: ImageAssets.call,
              details: Order!.delivery!.phones.toString(),
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrderInBasketContent(
                categoriesName: Order!.cartViews!.first.productName.toString(),
                imageSrc: Order!.cartViews!.first.imageUrl.toString(),
                price: Order!.totalPrice!.toDouble(),
                quantity: Order!.cartViews!.first.quantity.toString(),
              );
            },
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: Order!.cartViews!.length,
          ),

          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "السعر",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Spacer(),
              Text(
                Order!.totalPrice!.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
          Row(
            children: [
              const Text(
                "الديلفري",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Spacer(),
              Text(
                Order!.fees.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
          const DottedLine(
              dashColor: Colors.grey, dashLength: 11, dashGapLength: 10),
          SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
          Row(
            children: [
              const Text(
                "اجمالي السعر",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
              Spacer(),
              Text(
                Order!.totalPrice!.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
            ],
          ),

          SizedBox(height: mediaQueryHeight(context) / AppSize.s40),
          BlocConsumer<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is PostOrderSuccessState) {
                showToast(
                    text: 'Order Accepted Successfully',
                    state: ToastStates.SUCCESS);

                showDialog(
                    context: context,
                    builder: (_) {
                      return alertDialog(
                        imageSrc: 'assets/images/menu/profile.png',
                        text: 'Order Accepted Successfully',
                      );
                    });
              } else if (state is PostOrderErrorState) {
                showToast(text: '${state.error}', state: ToastStates.ERROR);
              }
            },
            builder: (context, state) {
              if (state is FollowOrderSuccessState) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppSize.s40),
                  child: (!OrderCubit.get(context)
                          .acceptedModel!
                          .isAcceptedByDelivery!)
                      ? Row(
                          children: [
                            ScoundButton(
                              onPressed: () {
                                OrderCubit.get(context).folowOrders(
                                    orderId: Order!.orderId!.toInt());
                                OrderCubit.get(context).postOrder(
                                    orderId: Order!.orderId!.toInt());
                              },
                              mainColor: Colors.green,
                              scoundColor: Colors.green.shade50,
                              text: 'قبول',
                            ),
                            SizedBox(
                                width: mediaQueryWidth(context) / AppSize.s5),
                            ScoundButton(
                              onPressed: () {
                                OrderCubit.get(context).folowOrders(
                                    orderId: Order!.orderId!.toInt());
                                navigateFinalTo(
                                    context: context,
                                    screenRoute: Routes.homeDrawer);
                              },
                              mainColor: Colors.red,
                              scoundColor: Colors.red.shade50,
                              text: 'رفض',
                            ),
                          ],
                        )
                      : SizedBox(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
