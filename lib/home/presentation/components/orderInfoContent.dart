import 'package:dotted_line/dotted_line.dart';
import 'package:elagk_delivery/drawer/presentation/controller/about_us_controller/about_us_state.dart';
import 'package:elagk_delivery/home/data/models/accepted_model.dart';
import 'package:elagk_delivery/home/presentation/components/salary_widget.dart';
import 'package:elagk_delivery/home/presentation/components/scound_button.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_state.dart';
import 'package:elagk_delivery/shared/utils/app_constants.dart';
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
import 'button2.dart';
import 'info_content_widget2.dart';
import 'informations_content_widget.dart';
import 'orders_components/orderBasketContent.dart';
import 'orders_components/orders_phone_container_widget.dart';

class OrderInformationContent extends StatelessWidget {
  OrderInformationContent({
    Key? key,
    this.Order,
  }) : super(key: key);
  final OrdersModel? Order;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit,OrderState>(
      listener: (context,state){
        if (state is PostOrderSuccessState) {
          showDialog(
              context: context,
              builder: (_) {
                return alertDialog(
                  imageSrc: JsonAssets.orderAccepted,
                  text:
                  'تم قبول الطلب بنجاح',
                );
              });

        }else if(state is OrderDeliverDoneSuccessState)
        {
          showDialog(
              context: context,
              builder: (_) {
                return alertDialog(
                  imageSrc: JsonAssets.orderAccepted,
                  text:
                  'تم تسليم الطلب بنجاح',
                );
              });
        }

        else if (state is PostOrderErrorState) {
          showToast(text: '${state.error}', state: ToastStates.ERROR);
        }
      },
      builder: (context,state){
        if(OrderCubit.get(context).acceptedModel!=null) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //deliver to
                  InformationContentSection2(
                    ontap: (){
                      ContactUsCubit.get(context).openMap(
                          Order!.destinationLatitude!.toDouble(),
                          Order!.destinationLongitude!.toDouble());
                    },
                    text: AppStrings.deliverTo,

                    text1: Order!.address.toString(),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //pharmacy name
                  InformationContentSection(

                    text: AppStrings.pharmacyName,

                    text1:Order!.pharmacy!.pharmacyName.toString(),
                    image: 'assets/images/drawer_icons/phamacy.png',

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //client name
                  InformationContentSection(
                    text: AppStrings.clientName,
                    image: 'assets/images/login/boss(1).png',
                    text1: Order!.delivery!.firstName.toString() +
                        Order!.delivery!.lastName.toString(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //phone number
                  InkWell(
                    onTap: (){
                      launch("tel:${Order!.delivery!.phones}");
                    },
                    child: InformationContentSection(
                      text: AppStrings.phoneNumber,
                      image:  ImageAssets.call,
                      text1:  Order!.delivery!.phones!.first.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //carts
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderInBasketContent(
                        categoriesName: Order!.cartViews![index].productName.toString(),
                        imageSrc: Order!.cartViews![index].imageUrl.toString(),
                        price: Order!.cartViews![index].price!.toDouble(),
                        quantity: Order!.cartViews![index].quantity.toString(),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: Order!.cartViews!.length,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SalarySection(text:Order!.totalPrice!.toString(), text1:  "السعر",color: Colors.black,),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
                  SalarySection(text: Order!.fees.toString(), text1: "الديلفري",color: Colors.black,),

                  SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
                  const DottedLine(
                      dashColor: Colors.grey, dashLength: 11, dashGapLength: 10),
                  SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
                  SalarySection(text:Order!.totalPrice!.toString(), text1: "اجمالي السعر",color: Colors.green,),

                  SizedBox(height: mediaQueryHeight(context) / AppSize.s40),
                  Padding(
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
                            navigateFinalTo(
                                context: context,
                                screenRoute: Routes.homeDrawer);
                            //post notify to client
                            OrderCubit.get(context).postNotification(
                                UserID:
                                Order!.userId!, notifiactionTitle: "order Progress",
                                notifiactionDescription:
                                "your order On the way");
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

                            //post notify to pharmacy
                            OrderCubit.get(context).postNotification(
                                UserID:
                                Order!.pharmacy!.userId!, notifiactionTitle:
                            "order Progress",
                                notifiactionDescription:
                                "the order ${Order!.orderId!} rejected by delivery "
                                    "${AppConstants.userModel!.firstName}");
                          },
                          mainColor: Colors.red,
                          scoundColor: Colors.red.shade50,
                          text: 'رفض',
                        ),
                      ],
                    )
                        : (!OrderCubit.get(context)
                        .acceptedModel!
                        .isDelivered!)
                        ?Center(child:  Button(
                      onPressed: () {
                        OrderCubit.get(context)
                            .postOrderDeliverDone(orderId:Order!.orderId);
                        OrderCubit.get(context).folowOrders(
                            orderId: Order!.orderId!.toInt());
                        navigateTo(context: context, screenRoute: Routes.homeDrawer);
                      },
                      mainColor: Colors.green,
                      scoundColor: Colors.green.shade50,
                      text: 'تم تاكيد التسليم',
                    ),):
                        SizedBox()
                  )

                ],
              ),
            ),
          );
        } else {
          return const Center(child:
          CircularProgressIndicator(color: AppColors.primary,),);
        }

      },

    );
  }
}