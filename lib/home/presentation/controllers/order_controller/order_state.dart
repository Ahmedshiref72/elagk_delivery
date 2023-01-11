
import 'package:elagk_delivery/drawer/data/models/profile/user_profile_model.dart';

import '../../../data/models/orders_model.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class PostOrderLoadingState  extends OrderState {}
class PostOrderSuccessState  extends OrderState {}
class PostOrderErrorState  extends OrderState
{
  final String error;

  PostOrderErrorState(this.error);
}
class FollowOrderLoadingState  extends OrderState {}
class FollowOrderSuccessState  extends OrderState {}
class FollowOrderErrorState  extends OrderState
{
  final String error;

  FollowOrderErrorState(this.error);
}

