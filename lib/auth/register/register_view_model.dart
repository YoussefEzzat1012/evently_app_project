
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:route/auth/register/register_navigator.dart';

import '../../models/my_user.dart';
import '../../utils/dialog_utils.dart';

class RegisterViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
  late RegisterNavigator navigator;
  void register(String email, String password) async{
    navigator.showMyLoading(message: "Loading...");
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //todo: hide loading dialog
      navigator.hideMyLoading();
      //todo: show message
      navigator.showMyMessage(message: "Registered Successfully",);

      // MyUser user = MyUser(
      //   id: credential.user?.uid ?? "",
      //   name: nameController.text,
      //   email: email,
      // );
      // await FirebaseUtils.addUserToFirebase(user);
      // Provider.of<UserProvider>(context, listen: false).updateUser(user);
      // Provider.of<EventListProvider>(context, listen: false).changeSelectedIndex(0, user.id);
      //
      // //todo: show message
      // DialogUtils.showMessage(context: context, message: "Registered Successfully", title: "Success", posActionText: "OK" ,posAction: () {
      //   Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRouteName, (route) => false);
      // });
    } on FirebaseAuthException catch (e) {
      //todo: hide loading dialog
      navigator.hideMyLoading();
      //todo: show message
      navigator.showMyMessage(message: "The email address is already in use by another account..",);
    } catch (e) {
      navigator.hideMyLoading();
      navigator.showMyMessage(message: e.toString());
    }
  }
}