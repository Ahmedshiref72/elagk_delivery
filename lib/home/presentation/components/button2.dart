import 'package:flutter/material.dart';

import '../../../shared/utils/app_values.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.onPressed, required this.mainColor, required this.scoundColor, required this.text,}) : super(key: key);
  final Function onPressed;
  final Color mainColor;
  final Color scoundColor;
  final String text;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(color:scoundColor),
        width: AppSize.s200,
        height: AppSize.s50,
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color:mainColor, fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
