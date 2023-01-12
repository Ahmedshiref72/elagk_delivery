import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:elagk_delivery/home/data/models/accepted_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/local/shared_preference.dart';
import '../../../../shared/network/api_constants.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/utils/app_constants.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());

  static OrderCubit get(context) => BlocProvider.of(context);


  Future<void> postOrder({
    required orderId}) async {
    emit(PostOrderLoadingState());
    DioHelper.postData(
      url: ApiConstants.postOrder(
          CacheHelper.getData(key: AppConstants.userId), orderId),

    ).then((value) {
      emit(PostOrderSuccessState());
    }).catchError((onError) {
      emit(PostOrderErrorState(onError.toString()));
      print(onError.toString());
    });
  }






}
