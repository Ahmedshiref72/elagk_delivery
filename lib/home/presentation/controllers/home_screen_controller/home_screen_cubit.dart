import 'package:dio/dio.dart';
import 'package:elagk_delivery/drawer/data/models/profile/user_profile_model.dart';
import 'package:elagk_delivery/home/presentation/controllers/home_screen_controller/home_screen_state.dart';
import 'package:elagk_delivery/home/presentation/controllers/order_controller/order_cubit.dart';
import 'package:elagk_delivery/shared/local/shared_preference.dart';
import 'package:elagk_delivery/shared/network/api_constants.dart';
import 'package:elagk_delivery/shared/network/dio_helper.dart';
import 'package:elagk_delivery/shared/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/models/accepted_model.dart';
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

  LocationPermission? permission;

  void getPermission() {
    emit(GetPermissionLoadingState());
    locationPermission();
  }

  Future<void> locationPermission() async {
    var status = await Permission.location.request();
    if (status == Null){
      permission = await Geolocator.requestPermission().then((value) async {
        var status = await Permission.location.request();
        emit(GetPermissionSuccessState());
        if (status == PermissionStatus.denied ||
            status == PermissionStatus.permanentlyDenied) {
          emit(GetPermissionErrorState());
          permission = await Geolocator.requestPermission();
        } else {
          getUserLocation();
        }
      })
          .catchError((onError) {
        emit(GetPermissionErrorState());
        print('fff');
        print(onError);
        print(permission);
      });}
    else {
      if (status == PermissionStatus.denied ||
          status == PermissionStatus.permanentlyDenied) {
        emit(GetPermissionErrorState());
      } else {
        getUserLocation();
      }
    }
  }

  //get Current Location
  LatLng? currentPostion;

  Future<void> getUserLocation() async {
    await GeolocatorPlatform.instance.getCurrentPosition().then((value) {
      currentPostion = LatLng(value.latitude, value.longitude);
      getCurrentLocation(currentPostion!.latitude, currentPostion!.longitude);
      AppConstants.myLat = currentPostion!.latitude;
      AppConstants.myLong = currentPostion!.longitude;
    });
  }

  Future<void> getCurrentLocation(lat, long) async {
    List<Address> addresses;
    final coordinates = new Coordinates(lat, long);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    emit(GetUserLocationState());
    AppConstants.currentLocation = addresses
        .sublist(3,addresses.length)
        .first
        .addressLine
        .toString();
    // print("${addresses.addressLine}");
    // print("permission:${permission.toString()}");
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



}
