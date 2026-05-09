import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../home/widgets/custom_elevated_button.dart';
import '../../home/widgets/cutsom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController(text: "ezzat22@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456");
  TextEditingController nameController = TextEditingController(text: "youssef");
  TextEditingController rePasswordController = TextEditingController(text: "123456");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
            color: AppColors.blackColor
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register, style: AppStyle.bold20Black,),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.logo),
                SizedBox(height: height * 0.02),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CutsomTextFormFeild(
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                        prefixIcon: Image.asset(AppAssets.iconName),
                        hintText: AppLocalizations.of(context)!.name,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your Name";
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CutsomTextFormFeild(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        prefixIcon: Image.asset(AppAssets.emailIcon),
                        hintText: AppLocalizations.of(context)!.email,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CutsomTextFormFeild(
                        controller: passwordController,
                        prefixIcon: Image.asset(AppAssets.passwordIcon),
                        suffixIcon: Image.asset(AppAssets.iconShowPassword),
                        obSecureText: true,
                        obscuringCharacter: "*",
                        hintText: AppLocalizations.of(context)!.password,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your password";
                          }
                          if (text.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CutsomTextFormFeild(
                        controller: rePasswordController,
                        prefixIcon: Image.asset(AppAssets.passwordIcon),
                        suffixIcon: Image.asset(AppAssets.iconShowPassword),
                        obSecureText: true,
                        obscuringCharacter: "*",
                        hintText: "Re${AppLocalizations.of(context)!.password}",
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your password";
                          }
                          if (text != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: register,
                        text: AppLocalizations.of(context)!.register,
                        textStyle: AppStyle.bold20White,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.iAlreadyHaveAccount, style: AppStyle.bold16Black,),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyle.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: register,
                        text: AppLocalizations.of(context)!.loginWithGoogle,
                        backGroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        textStyle: AppStyle.bold20Primary,
                        hasIcon: true,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }

  void register() async{
    if(formKey.currentState!.validate() == true) {
      //show loading dialog
      DialogUtils.showDidalog(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading dialog
        DialogUtils.hideDialog(context);
        //todo: show message
        DialogUtils.showMessage(context: context, message: "Registered Successfully", title: "Success", posActionText: "OK" ,posAction: () {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRouteName, (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        //todo: hide loading dialog
        print(e.toString());
        DialogUtils.hideDialog(context);
        //todo: show message

          DialogUtils.showMessage(context: context, message: 'The email address is already in use by another account..', title: "Alert", posActionText: "OK" ,posAction: () {
          });

      } catch (e) {
        print("nnoooonno");
        DialogUtils.showMessage(context: context, message: e.toString(), title: "Alert", posActionText: "OK" ,posAction: () {
        });
      }
        //Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRouteName, (route) => false);
    }
  }
}
