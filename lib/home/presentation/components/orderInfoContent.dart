import 'package:dotted_line/dotted_line.dart';
import 'package:elagk_delivery/auth/presentation/components/main_button.dart';
import 'package:elagk_delivery/home/presentation/components/scound_button.dart';
import 'package:flutter/material.dart';

import '../../../notification/components/notification_item_widget.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_constants.dart';
import '../../../shared/utils/app_strings.dart';
import '../../../shared/utils/app_values.dart';
import '../../data/models/orders_model.dart';
import 'orders_components/my_devider_component.dart';
import 'orders_components/orderBasketContent.dart';
import 'orders_components/order_item_content.dart';

class OrderInformationContent extends StatelessWidget {
   OrderInformationContent({Key? key, this.Order}) : super(key: key);
  final OrdersModel? Order;
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
              Container(
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
            'مدينة نصر - التجمع الخامس -شارع افريقياالسينمائى',
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
              SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.clientName,
                style: Theme.of(context).textTheme.displayLarge,
              ),

            ],
          ),
          Text(
            'ahmed mohamed shiref',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),

          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderInBasketContent(
                  categoriesName: 'Order!.name.',
                  imageSrc: ImageAssets.elagkWord,
                  price:3.toString(),
                  quantity: 'Order!.quantity',
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: Order!.cartViews!.length,
          ),

          const SizedBox(
            height: 20,
          ),
          Row(
            children:  [
              Text(
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
            children:  [
              Text(
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
          DottedLine(dashColor: Colors.grey, dashLength: 11, dashGapLength: 10),
          SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
          Row(
            children:  [
              Text(
                "اجمالي السعر",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.green),
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
          Padding(
            padding: const EdgeInsets.only(right:AppSize.s40),
            child: Row(
              children: [
                ScoundButton(
                    onPressed: (){},
                    mainColor: Colors.green,
                    scoundColor: Colors.green.shade50, text: 'قبول',),
                SizedBox(width: mediaQueryWidth(context) / AppSize.s5),
                ScoundButton(
                    onPressed: (){},
                    mainColor: Colors.red,
                    scoundColor: Colors.red.shade50, text: 'رفض',),


              ],
            ),
          ),

        ],
      ),
    );
  }
}
