import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/firebase_utils.dart';
import 'loginNavigator.dart';

class LoginViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
  late LoginNavigator navigator;
  final formKey = GlobalKey<FormState>();


  //todo: data
  TextEditingController emailController = TextEditingController(
    text: "ezzat22@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //todo: show loading
      navigator.showMyLoading(message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.getUserFromFirebaseFireStore(
          credential.user?.uid ?? "",
        );
        if (user == null) {
          return;
        }
        navigator.updateUserProvider(user: user);
        navigator.changeSelectedIndex(index: 0, userId: user.id);
        navigator.getAllFavoriteEvents(userId: user.id);
        //todo: hide loading dialog
        navigator.hideMyLoading();
        //todo: show message
        navigator.showMyMessage(message: "Loogin Successfully");
        navigator.navigateToHomeScreen();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading dialog
          navigator.hideMyLoading();
          //todo: show message
          navigator.showMyMessage(message: "Email or password is not correct");
        }
      } catch (e) {
        //todo: hide loading dialog
        navigator.hideMyLoading();
        //todo: show message
        navigator.showMyMessage(message: e.toString());
      }
    }
  }
}
