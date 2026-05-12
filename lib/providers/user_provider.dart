

import 'package:flutter/cupertino.dart';
import 'package:route/models/my_user.dart';

class UserProvider extends ChangeNotifier{

  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}