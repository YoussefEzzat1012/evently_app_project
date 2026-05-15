
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:route/auth/register/register_navigator.dart';

import '../../models/my_user.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/firebase_utils.dart';

class RegisterViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
  late RegisterNavigator navigator;
  final formKey = GlobalKey<FormState>();
  //todo: data
  TextEditingController emailController = TextEditingController(text: "ezzat22@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456");
  TextEditingController nameController = TextEditingController(text: "youssef");
  TextEditingController rePasswordController = TextEditingController(text: "123456");

  void register() async {
    if (formKey.currentState!.validate() == true) {
      navigator.showMyLoading(message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final userAuth = credential.user;
        if (userAuth == null) {
          throw Exception("User is null after registration");
        }
        MyUser user = MyUser(
          id: userAuth.uid,
          name: nameController.text,
          email: emailController.text,
        );
        print(user.toString());
        await FirebaseUtils.addUserToFirebase(user);
        navigator.updateUserProvider(user: user);
        navigator.changeSelectedIndex(index: 0, userId: user.id);
        //todo: hide loading dialog
        navigator.hideMyLoading();
        //todo: show message
        navigator.showMyMessage(message: "Registered Successfully",);
        navigator.navigateToHomeScreen();

      } on FirebaseAuthException catch (e) {
        //todo: hide loading dialog
        navigator.hideMyLoading();
        //todo: show message
        navigator.showMyMessage(
          message: "The email address is already in use by another account..",);
      } catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage(message: e.toString());
      }
    }
  }
}