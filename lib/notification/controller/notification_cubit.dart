import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/local/shared_preference.dart';
import '../../../../shared/network/api_constants.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/utils/app_constants.dart';
import '../data/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);



  //get notification
  List<NotificationModel> notifications = [];
  Future<void> getNotifications() async {
    notifications = [];

    emit(GetNotificationLoadingState());
    try {
      Response response = await DioHelper.getData(
          url:  ApiConstants.getNotifications(
              CacheHelper.getData(key: AppConstants.userId)));
      notifications = (response.data as List)
          .map((x) => NotificationModel.fromJson(x))
          .toList();
      notifications=notifications.reversed.toList();
      print(notifications.length);

      emit(GetNotificationSuccessState(notifications));
    } catch (error, stacktrace) {
      emit(GetNotificationErrorState(error.toString()));

      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

}
