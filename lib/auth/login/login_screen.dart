import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:route/auth/login/loginViewModel.dart';
import 'package:route/models/my_user.dart';
import 'package:route/providers/event_list_provider.dart';
import 'package:route/utils/dialog_utils.dart';
import '../../home/widgets/custom_elevated_button.dart';
import '../../home/widgets/cutsom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/firebase_utils.dart';
import 'loginNavigator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginViewModel viewModel = LoginViewModel();

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.logo),
                SizedBox(height: height * 0.02),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CutsomTextFormFeild(
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.emailController,
                        prefixIcon: Image.asset(AppAssets.emailIcon),
                        hintText: AppLocalizations.of(context)!.email,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CutsomTextFormFeild(
                        controller: viewModel.passwordController,
                        prefixIcon: Image.asset(AppAssets.passwordIcon),
                        suffixIcon: Image.asset(AppAssets.iconShowPassword),
                        obSecureText: true,
                        obscuringCharacter: "*",
                        hintText: AppLocalizations.of(context)!.password,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "${AppLocalizations.of(context)!.forgetPassword}?",
                            style: AppStyle.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                        onPressed: viewModel.login,
                        text: AppLocalizations.of(context)!.login,
                        textStyle: AppStyle.bold20White,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dontHaveAccount,
                            style: AppStyle.bold16Black,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.registerRouteName,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: AppStyle.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              thickness: 2,
                              indent: width * 0.02,
                              endIndent: width * 0.02,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyle.bold16Primary,
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryColor,
                              thickness: 2,
                              indent: width * 0.02,
                              endIndent: width * 0.02,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: viewModel.login,
                        text: AppLocalizations.of(context)!.loginWithGoogle,
                        backGroundColor: AppColors.whiteColor,
                        borderColor: AppColors.primaryColor,
                        textStyle: AppStyle.bold20Primary,
                        hasIcon: true,
                        childIconWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Bootstrap.google),
                            SizedBox(width: width * 0.04),
                            Text(
                              AppLocalizations.of(context)!.loginWithGoogle,
                              style: AppStyle.bold16Primary,
                            ),
                          ],
                        ),
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
    DialogUtils.showMessage(
      context: context,
      message: message,
      title: "Alert",
      posActionText: "OK",
      posAction: navigateToHomeScreen,
    );
  }

  @override
  void navigateToHomeScreen() {
    // TODO: implement navigateToHomeScreen
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRouteName, (route) => false);
  }

  @override
  void updateUserProvider({required MyUser user}) {
    // TODO: implement updateUserProvider
    Provider.of<UserProvider>(context, listen: false).updateUser(user);
  }

  @override
  void changeSelectedIndex({required int index, required String userId}) {
    // TODO: implement changeSelectedIndex
    Provider.of<EventListProvider>(context, listen: false).changeSelectedIndex(index, userId);
  }

  @override
  void getAllFavoriteEvents({required String userId}) {
    // TODO: implement getAllFavoriteEvents
    Provider.of<EventListProvider>(context, listen: false).getAllFavoriteEvents(userId);
  }
}
