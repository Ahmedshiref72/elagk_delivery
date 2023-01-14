import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elagk_delivery/auth/presentation/components/MainTextFormField.dart';
import 'package:elagk_delivery/auth/presentation/components/auth_title_subtitle_widget.dart';
import 'package:elagk_delivery/auth/presentation/components/logo_widget.dart';
import 'package:elagk_delivery/auth/presentation/components/main_button.dart';
import 'package:elagk_delivery/auth/presentation/components/screen_background.dart';
import 'package:elagk_delivery/auth/presentation/controller/login_controller/login_cubit.dart';
import 'package:elagk_delivery/auth/presentation/controller/login_controller/login_states.dart';
import 'package:elagk_delivery/shared/components/toast_component.dart';
import 'package:elagk_delivery/shared/global/app_colors.dart';
import 'package:elagk_delivery/shared/utils/app_routes.dart';
import 'package:elagk_delivery/shared/utils/app_strings.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:elagk_delivery/shared/utils/text_field_validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body:BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {

                if (state.loginModel.roles![0]
                    .toString()
                    .toUpperCase() ==
                    'DELIVERY') {
                  showToast(
                      text: 'Login Successfully',
                      state: ToastStates.SUCCESS);
                  navigateFinalTo(
                      context: context,
                      screenRoute: Routes.homeDrawer);
                }else
                {
                  showToast(
                      text: 'This User Can\'t Access' ,
                      state: ToastStates.ERROR);
                }
              } else if (state is LoginErrorState) {
                showToast(
                    text: '${state.error}',
                    state: ToastStates.ERROR);
              }
            },
            builder: (context, state) {
              return ScreenBackground(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppPadding.p15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const LogoWidget(),
                          const AuthTitleAndSubtitle(
                            authTitle: AppStrings.login,
                            authSubtitle: AppStrings.pleaseLogin,
                          ),
                          MainTextFormField(
                            controller: _emailController,
                            label: AppStrings.email,
                            hint: AppStrings.emailExample,
                            hintColor: AppColors.lightGrey,
                            inputType: TextInputType.emailAddress,
                            textDirection: TextDirection.ltr,

                            isObsecured:false,
                            validator: (value) => validateEmail(value!),
                          ),
                          SizedBox(height: mediaQueryHeight(context) / AppSize.s30),
                          MainTextFormField(
                            isObsecured:LoginCubit.get(context).isObsecured ,
                            suffixIcon: IconButton(
                                color: Colors.white,
                                icon: LoginCubit.get(context).isObsecured?Icon(Icons.visibility,color: AppColors.primary,):
                                Icon(Icons.visibility_off,color: AppColors.primary,),
                                onPressed: (){
                                  LoginCubit.get(context).changeVisibility();
                                }),
                            controller: _passwordController,
                            label: AppStrings.password,
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  screenRoute: Routes.forgetPasswordScreen,
                                );
                              },
                              child: Text(
                                AppStrings.forgotPassword,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                  color: AppColors.yellowBold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryHeight(context) / AppSize.s80,
                          ),
                          ConditionalBuilder(condition:(state is LoginLoadingState),
                              builder: (context)=>const CircularProgressIndicator(),
                              fallback: (context)=>MainButton(
                                title: AppStrings.login,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text);
                                  }
                                },
                              )
                          ),

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


