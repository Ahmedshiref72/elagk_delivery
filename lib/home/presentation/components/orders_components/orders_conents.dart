
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/utils/app_values.dart';
import 'my_devider_component.dart';
import 'order_item_content.dart';

class OrdersContents extends StatelessWidget {
  const OrdersContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(

          child: ListView.separated(
              itemBuilder: (context, index) => Container(
                height: 80,
                width: double.infinity,
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:Image.asset(
                            'assets/images/order/order.png',
                          ),

                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text( 'الطلب رقم ', style: TextStyle
                          (
                            fontSize: 18,
                            fontWeight: FontWeight.bold

                        )),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(

                                '"yyyy-MM-dd"', style:
                            TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade500

                            )),
                            SizedBox(width: mediaQueryWidth(context) * 0.24,),
                            Text(' جنيه ', style:
                            TextStyle
                              (
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade500

                            )),

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: 5
          ),
        ),
      ],
    );
  }
}