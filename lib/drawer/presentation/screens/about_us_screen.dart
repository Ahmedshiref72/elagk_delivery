import 'package:elagk_delivery/drawer/presentation/components/about_us_components/about_us_content.dart';
import 'package:elagk_delivery/drawer/presentation/components/fixed_appbar_widget.dart';
import 'package:elagk_delivery/drawer/presentation/controller/about_us_controller/about_us_cubit.dart';
import 'package:elagk_delivery/drawer/presentation/controller/about_us_controller/about_us_state.dart';
import 'package:elagk_delivery/drawer/presentation/controller/contact_us_controller/contact_us_cubit.dart';
import 'package:elagk_delivery/drawer/presentation/controller/contact_us_controller/contact_us_state.dart';
import 'package:elagk_delivery/opening/presentation/screens/offline_widget.dart';
import 'package:elagk_delivery/shared/global/app_colors.dart';
import 'package:elagk_delivery/shared/utils/app_routes.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: fixedAppBar(
            context: context,
            title: AppStrings.aboutUs,
            actionWidget: Icon(Icons.add),
            onTap: () {
              navigateTo(
                context: context,
                screenRoute: Routes.basketScreen,
              );
            },
          ),
          body: BlocConsumer<AboutUsCubit, AboutUsState>(
            listener: (context, state)
            {
              // if(state is GetAboutUsErrorState)
              // {
              //   AboutUsCubit.get(context).getAboutUsWhoWeAre();
              //   AboutUsCubit.get(context).getAboutUsVision();
              // }
            },
            builder: (BuildContext context, state) {
              if (state is GetAboutUsLoadingState)
                return Center(child: CircularProgressIndicator(color: AppColors.primary,));
              else if (state is GetAboutUsErrorState)
                return OfflineWidget();
              else
                return AboutUsContent();
            },
          ),
        ),
      ),
    );
  }
}
