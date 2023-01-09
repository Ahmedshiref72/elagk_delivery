import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_values.dart';

class OrderInBasketContent extends StatelessWidget {
  const OrderInBasketContent({
    Key? key,
    required this.categoriesName,
    required this.imageSrc,
    required this.price,
    required this.quantity,

  }) : super(key: key);

  final String categoriesName;
  final String price;
  final String imageSrc;
  final String quantity;



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: AppSize.s120,
          width: mediaQueryWidth(context)*.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.s15),
          ),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s25),
                child: Image(
                  image: AssetImage('${imageSrc}'),
                  width: 100,
                  height: 120,
                ),
              ),
              SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mediaQueryHeight(context) / AppSize.s40),
                    Row(
                      children: [
                        Text(
                          categoriesName,
                          style:const TextStyle(
                              fontWeight: FontWeight.bold,

                              fontSize: 17
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth(context) / AppSize.s5),
                        Text(
                          '15 جنيه ',
                          style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                      ],
                    ),
                    SizedBox(height: mediaQueryHeight(context) / AppSize.s50),
                    Row(
                      children:  [
                        const Text(
                          'الكمية : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 17
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth(context) / AppSize.s20),
                         Text(
                           quantity,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),



                  ],
                ),
              ),
             

            ],
          ),
        ),
      ),
    );
  }
}
