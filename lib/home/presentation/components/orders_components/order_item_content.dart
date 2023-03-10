import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
import '../../../data/models/orders_model.dart';

  Widget OrderItem({required context,required OrdersModel ordersModel}) =>
      InkWell(
        onTap: (){

          OrderCubit.get(context).folowOrders(orderId: ordersModel.orderId!);

          navigateTo(
              context: context,
              screenRoute: Routes.orderInfo,
             arguments: ordersModel);
        },
        child: Container(
          height: 80,
          width: double.infinity,
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Image(
                      image: AssetImage(
                        'assets/images/order/4140048.png',
                      ),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )

                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Text( 'الطلب رقم '+ ordersModel.orderId.toString(), style: TextStyle
                        (
                          fontSize: 18,
                          fontWeight: FontWeight.bold

                      )),
                      SizedBox(width: mediaQueryWidth(context) * 0.2),
                      Text(

                          '${DateFormat("hh:mm a").format(DateTime.parse(
                              ordersModel.createdAt.toString()))}',
                          style:
                      TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500

                      )),

                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Colors.green,size: 15,),
                      Container(
                        width: mediaQueryWidth(context)*.6,
                        child: Text(

                        ordersModel.address.toString(),
                            overflow: TextOverflow.ellipsis,
                            style:
                        TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black

                        )),
                      ),

                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );





