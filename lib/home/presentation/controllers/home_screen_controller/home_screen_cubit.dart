import 'dart:async';
import 'package:dio/dio.dart';
import 'package:elagk_delivery/drawer/data/models/profile/user_profile_model.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/main.dart';
import 'package:elagk_delivery/notification/data/notification_model.dart';
import 'package:elagk_delivery/shared/config/noti.dart';
import 'package:elagk_delivery/shared/local/shared_preference.dart';
import 'package:elagk_delivery/shared/network/api_constants.dart';
import 'package:elagk_delivery/shared/network/dio_helper.dart';
import 'package:elagk_delivery/shared/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/orders_model.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitialState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);


//userData
  Future<void> getUserProfileData() async {
    emit(ProfileGetUserDataLoadingState());
    print(CacheHelper.getData(key: AppConstants.userId));
    await DioHelper.getData(
      url: ApiConstants.UserIdPath(
          CacheHelper.getData(key: AppConstants.userId).toString()),
    ).then((value) {
      AppConstants.userModel = UserProfileModel.fromJson(value.data);
      print(AppConstants.userModel!.lastName!);
      emit(ProfileGetUserDataSuccessState(AppConstants.userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileGetUserDataErrorState(error.toString()));
    });
  }







//orders
  OrdersModel? ordersModel;
  List<OrdersModel> Orders = [];
  //List<CartViews> carts = [];

  Future<void> getOrders() async {
    Orders = [];

    emit(GetOrdersLoadingState());
    try {
      Response response = await DioHelper.getData(
          url:  ApiConstants.getUserOrdersByDeliveryId(
              CacheHelper.getData(key: AppConstants.userId)));
      Orders = (response.data as List)
          .map((x) => OrdersModel.fromJson(x))
          .toList();
      Orders=Orders.reversed.toList();
      print(CacheHelper.getData(key: AppConstants.userId));
      print(Orders.length);
     // print(carts.length);
      emit(GetOrdersSuccessState(Orders));
    } catch (error, stacktrace) {
      emit(GetOrdersErrorState(error.toString()));

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //get notification
  List<NotificationModel> notifications = [];
  NotificationModel? lastNotification;

  Timer? timer;

  Future<void> getNotifications() async {
    notifications = [];

    emit(GetNotificationLoadingState());

    try {
      Response response = await Dio().get(
          ApiConstants.getNotifications(
              CacheHelper.getData(key: AppConstants.userId)));
      notifications = (response.data as List)
          .map((x) => NotificationModel.fromJson(x))
          .toList();
      notifications=notifications.reversed.toList();
      print(notifications.length);
      print(CacheHelper.getData(key: AppConstants.userId));
      if(AppConstants.notificationLength<notifications.length) {
        lastNotification=notifications.first;
        getNotify();
      }
      AppConstants.notificationLength=notifications.length;

      emit(GetNotificationSuccessState(notifications));
    } catch (error, stacktrace) {
      emit(GetNotificationErrorState(error.toString()));

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }

  }

  void getNotify()
  {

    Noti.showBigTextNotification(
        title: "${lastNotification!.notifiactionTitle}",
        body: "${lastNotification!.notifiactionDescription}",
        fln: flutterLocalNotificationsPlugin);

  }

  void checkNotifications()
  {
    timer = Timer.periodic(Duration(seconds: 20), (Timer t)=>getNotifications());

  }



}
