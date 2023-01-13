
import 'package:elagk_delivery/drawer/data/models/profile/user_profile_model.dart';
import 'package:elagk_delivery/notification/data/notification_model.dart';

import '../../../data/models/orders_model.dart';

abstract class HomeScreenState {}

class HomeScreenInitialState extends HomeScreenState {}

class ProfileGetUserDataLoadingState  extends HomeScreenState {}
class ProfileGetUserDataSuccessState  extends HomeScreenState
{
  final UserProfileModel userModel;

  ProfileGetUserDataSuccessState(this.userModel);
}
class ProfileGetUserDataErrorState  extends HomeScreenState
{
  final String error;

  ProfileGetUserDataErrorState(this.error);
}


class GetPharmaciesLoadingState extends HomeScreenState {}

class GetPharmaciesSuccessState extends HomeScreenState
{
}

class GetPharmaciesErrorState extends HomeScreenState
{
  final String error;

  GetPharmaciesErrorState(this.error);
}

class GetUserLocationState extends HomeScreenState {}

class GetPermissionLoadingState extends HomeScreenState {}

class GetPermissionSuccessState extends HomeScreenState {}

class GetPermissionErrorState extends HomeScreenState {}


//orders
class GetOrdersLoadingState extends HomeScreenState {}
class GetOrdersSuccessState extends HomeScreenState
{
  final List<OrdersModel> model;

  GetOrdersSuccessState(this.model);
}
class GetOrdersErrorState extends HomeScreenState
{
  final String error;

  GetOrdersErrorState(this.error);
}

//filter

class FilterOrdersLoadingState extends HomeScreenState {}
class FilterOrdersSuccessState extends HomeScreenState {}


class GetNotificationLoadingState  extends HomeScreenState {}
class GetNotificationSuccessState  extends HomeScreenState {
  final List<NotificationModel> model;

  GetNotificationSuccessState(this.model);
}
class GetNotificationErrorState  extends HomeScreenState
{
  final String error;

  GetNotificationErrorState(this.error);
}