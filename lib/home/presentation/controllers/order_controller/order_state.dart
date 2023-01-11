
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


class getPharmacyByIdLoadingState  extends OrderState {}
class getPharmacyByIdSuccessState  extends OrderState {}
class getPharmacyByIdErrorState  extends OrderState
{
  final String error;

  getPharmacyByIdErrorState(this.error);
}
