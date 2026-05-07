
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils{
  static void showToastMsg({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
    );
  }
}