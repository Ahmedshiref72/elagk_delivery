import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elagk_delivery/auth/presentation/components/MainTextFormField.dart';
import 'package:elagk_delivery/auth/presentation/components/auth_title_subtitle_widget.dart';
import 'package:elagk_delivery/auth/presentation/components/logo_widget.dart';
import 'package:elagk_delivery/auth/presentation/components/main_button.dart';
import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/drawer/presentation/controller/profile_controller/profile_cubit.dart';
import 'package:elagk_delivery/shared/components/second_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../shared/components/toast_component.dart';
import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_bar_icon.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/utils/app_strings.dart';
import '../../../../shared/utils/app_values.dart';
import '../../../../shared/utils/navigation.dart';


class ResetPasswordScreenByOldPassword extends StatelessWidget {

  static final _changePasswordformKey = new GlobalKey<FormState>();
  static final _oldPasswordController = TextEditingController();
  static final _newPasswordController = TextEditingController();
  bool _hasInternet = false;



  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: SecondAppBar(
            context: context,
            title: AppStrings.editProfile,
            onTap: () {
              navigateTo(
                context: context,
                screenRoute: Routes.notification,
              );
            },
            actionWidget:AppBarIcon(),
          ),
          resizeToAvoidBottomInset: true,
          body:  BlocConsumer<ProfileCubit,ProfileStates>(
            listener: (context, state) {
              if (state is ProfileChangePasswordSuccessState) {
                {
                  showToast(
                      text: AppStrings.resetPassword,
                      state: ToastStates.SUCCESS);

                }

              } else if (state is ProfileChangePasswordErrorState) {
                showToast(
                    text: AppStrings.erorrResetPassword,
                    state: ToastStates.ERROR);
              }
            },
            builder: (context,state){

              if (state is ProfileChangePasswordSuccessState) {
                _newPasswordController.text="";
                _oldPasswordController.text="";

              }
              return ScreenBackground(

                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppPadding.p15),
                    child: Form(
                      key: _changePasswordformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LogoWidget(),
                          const AuthTitleAndSubtitle(
                            authTitle: AppStrings.changePassword,
                            authSubtitle: AppStrings.pleaseEnterOldPass,
                          ),
                          MainTextFormField(
                            isObsecured:ProfileCubit.get(context).isObsecured ,
                            suffixIcon: IconButton(
                                color: Colors.white,
                                icon: ProfileCubit.get(context).isObsecured?Icon(Icons.visibility,color: AppColors.blue,):
                                Icon(Icons.visibility_off,color: AppColors.blue,),
                                onPressed: (){
                                  ProfileCubit.get(context).changeVisibility();
                                }),
                            controller: _oldPasswordController,
                            label: AppStrings.oldPassword,
                            hint: AppStrings.passwordExample,
                            hintColor: AppColors.lightGrey,
                            inputType: TextInputType.visiblePassword,
                            textDirection: TextDirection.ltr,

                            validator: (value) {
                              if (value!.length < AppSize.s8) {
                                return AppStrings.enterValidPassword;
                              } else {
                                return null;
                              }
                            },                      ),
                          SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                          MainTextFormField(
                            isObsecured:ProfileCubit.get(context).isObsecured ,
                            suffixIcon: IconButton(
                                color: Colors.white,
                                icon: ProfileCubit.get(context).isObsecured?Icon(Icons.visibility,color: AppColors.blue,):
                                Icon(Icons.visibility_off,color: AppColors.blue,),
                                onPressed: (){
                                  ProfileCubit.get(context).changeVisibility();
                                }),
                            controller: _newPasswordController,
                            label: AppStrings.newPassword,
                            hint: AppStrings.passwordExample,
                            hintColor: AppColors.lightGrey,
                            inputType: TextInputType.visiblePassword,
                            textDirection: TextDirection.ltr,

                            validator: (value) {
                              if (value!.length < AppSize.s8) {
                                return AppStrings.enterValidPassword;
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                          FlutterPwValidator(
                            successColor: AppColors.primary,
                            controller: _newPasswordController,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 3,
                            specialCharCount: 1,
                            normalCharCount: 1,
                            width: mediaQueryWidth(context)*.8,
                            height: 150,
                            onSuccess: (){

                              return 'Success';
                            },
                            onFail: (){
                              return 'Password is Weak';
                            },
                          ),
                          SizedBox(height: mediaQueryHeight(context) / AppSize.s20),
                          ConditionalBuilder(
                            condition: state is! ProfileChangePasswordLoadingState,
                            builder: (context) => MainButton(
                                title: AppStrings.codeSendButton,
                                onPressed: () async
                                {
                                  _hasInternet =
                                  await InternetConnectionChecker().hasConnection;
                                  if (_hasInternet) {
                                    if (_changePasswordformKey.currentState!.validate()) {
                                      ProfileCubit.get(context)
                                          .changePassword(
                                          oldPassword: _oldPasswordController.text.trim(),
                                          newPassword: _newPasswordController.text.trim()

                                      );
                                    }

                                  }
                                }


                            ),
                            fallback: (context) =>
                            const CircularProgressIndicator(),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
