import 'package:flutter/material.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';
class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: (){
          navigateTo(
              context: context,
              screenRoute: Routes.orderInfo);
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


                      Text( 'الطلب رقم ', style: TextStyle
                        (
                          fontSize: 18,
                          fontWeight: FontWeight.bold

                      )),
                      SizedBox(width: mediaQueryWidth(context) * 0.1,),
                      Text(

                          '"yyyy-MM-dd"', style:
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
                      Text(

                          'مصر الجديد-ام كوبرى الجديد -شقة 15', style:
                      TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black

                      )),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



