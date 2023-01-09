
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import '../../home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'app_values.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Container(
          child: Stack(children:[Icon(Icons.notifications_none_outlined),
            Positioned(
              bottom:AppSize.s12 ,
              left: AppSize.s8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.red,
                ),
                width: AppSize.s16,
                height: AppSize.s16,
                child: Center(
                  child: Text('${HomeScreenCubit
                      .get(context)
                      .Orders
                      .length}', style: TextStyle(
                      fontSize: 9,
                      color: Colors.white
                  ),),
                ),
              ),
            ),
          ] )
        );
      },
    );
  }
}
