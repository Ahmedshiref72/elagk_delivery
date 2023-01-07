
import 'package:elagk_delivery/auth/data/models/login_model/login_model.dart';
import 'package:elagk_delivery/auth/presentation/controller/login_controller/login_states.dart';
import 'package:elagk_delivery/drawer/data/models/profile/user_profile_model.dart';
import 'package:elagk_delivery/shared/local/shared_preference.dart';
import 'package:elagk_delivery/shared/network/api_constants.dart';
import 'package:elagk_delivery/shared/network/dio_helper.dart';
import 'package:elagk_delivery/shared/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  Future<void> userLogin({
    required String email,
    required String password,
  })
  async {
    emit(LoginLoadingState());
    await DioHelper.postData(
      url: ApiConstants.login,
      data:
      {
        "email": email,
        "password": password
      },
    ).then((value)
    {
      print(value.data.toString());

      loginModel = LoginModel.fromJson(value.data);
      CacheHelper.setData(key: AppConstants.userId, value: loginModel!.userId);
      CacheHelper.setData(key: AppConstants.token, value: loginModel!.token);
      CacheHelper.setData(key: AppConstants.userName, value: loginModel!.username);
      emit(LoginSuccessState(loginModel!));

    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState('Invalid Account or Password'));
    });
  }





}