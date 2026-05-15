import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:route/auth/register/register_navigator.dart';
import 'package:route/auth/register/register_view_model.dart';
import 'package:route/models/my_user.dart';
import 'package:route/utils/firebase_utils.dart';

import '../../home/widgets/custom_elevated_button.dart';
import '../../home/widgets/cutsom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/dialog_utils.dart' as FirbaseUtils;

class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  TextEditingController emailController = TextEditingController(text: "ezzat22@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456");
  TextEditingController nameController = TextEditingController(text: "youssef");
  TextEditingController rePasswordController = TextEditingController(text: "123456");

  final formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }

  void register() async{
    if(formKey.currentState!.validate() == true) {
        viewModel.register(emailController.text, passwordController.text);
        //Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRouteName, (route) => false);
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideDialog(context);
  }

  @override
  void showMyLoading({required String message}) {
    // TODO: implement showMyLoading
    DialogUtils.showDidalog(context: context, message: message);
  }

  @override
    void showMyMessage({required String message}) {
    // TODO: implement showMyMessage
    DialogUtils.showMessage(context: context, message: message, title: "Alert", posActionText: "OK");
  }
}
