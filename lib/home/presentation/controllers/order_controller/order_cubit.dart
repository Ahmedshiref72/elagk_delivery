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
  Future<void> postOrderDeliverDone({
    required orderId}) async {
    emit(OrderDeliverDoneLoadingState());
    DioHelper.postData(
      url: ApiConstants.postOrderDeliverDone(
          CacheHelper.getData(key: AppConstants.userId), orderId),

    ).then((value) {
      emit(OrderDeliverDoneSuccessState());
    }).catchError((onError) {
      emit(OrderDeliverDoneErrorState(onError.toString()));
      print(onError.toString());
    });
  }


  //follow

  StepperFollowModel? acceptedModel;

  Future<void> folowOrders({required int orderId}) async {
    emit(FollowOrderLoadingState());
    print('jjjjjjjjjjjjjj');
    print(orderId.toString());
    DioHelper.getData(
        url: ApiConstants.followOrder(orderId))
        .then((value) {
      acceptedModel = StepperFollowModel.fromJson(value.data);
      print('jjjjjjjjjjjjjj');
      print(acceptedModel!.isAcceptedByDelivery!);
      emit(FollowOrderSuccessState());
    }).catchError((oError) {
      print(oError.toString());
      emit(FollowOrderErrorState(oError.toString()));
    });
  }




}
