
import 'package:flutter/cupertino.dart';
import 'package:route/models/my_user.dart';

abstract class LoginNavigator{
  //todo: show loading
  void showMyLoading({required String message});
  //todo: hide loading
  void hideMyLoading();
  //todo: show message
  void showMyMessage({required String message});
  //todo: Navigate to home screen
  void navigateToHomeScreen();
  //todo: update user provider
  void updateUserProvider({required MyUser user});
  //todo: change selected index
  void changeSelectedIndex({required int index, required String userId});
  //todo: get all favorite events
  void getAllFavoriteEvents({required String userId});
}

