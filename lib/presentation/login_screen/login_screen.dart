import 'package:flutter_bloc_boilerplate/core/di/service_locator.dart';
import 'package:flutter_bloc_boilerplate/core/utils/validation_functions.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_elevated_button.dart';
import 'models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';
import 'package:flutter_bloc_boilerplate/presentation/login_screen/bloc/login_bloc.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Builder method with Dependency Injection
  /// 
  /// This uses the service locator to get LoginBloc instance
  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        // Get LoginBloc from service locator (with injected dependencies)
        create: (context) => locator<LoginBloc>()
          ..add(LoginInitialEvent()),
        child: LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.cyan300,
        resizeToAvoidBottomInset: false,
        body: BlocListener<LoginBloc, LoginState>(
          // Listen to state changes for navigation and snackbar
          listener: (context, state) {
            // Show error message if login fails
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
            
            // Navigate to dashboard on successful login
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              
              // Navigate to dashboard after short delay
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.dashboardContainerScreen,
                );
              });
            }
          },
          child: SizedBox(
            width: SizeUtils.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 35.v),
                  child: Column(children: [
                    SizedBox(height: 70.v),
                    _buildPageTitle(context),
                    SizedBox(height: 32.v),
                    
                    // Email field
                    BlocSelector<LoginBloc, LoginState, TextEditingController?>(
                        selector: (state) => state.emailController,
                        builder: (context, emailController) {
                          return CustomTextFormField(
                              controller: emailController,
                              hintText: "lbl_your_email".tr,
                              textInputType: TextInputType.emailAddress,
                              prefix: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgSystemIcon,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize)),
                              prefixConstraints: BoxConstraints(maxHeight: 48.v),
                              validator: (value) {
                                if (value == null ||
                                    (!isValidEmail(value, isRequired: true))) {
                                  return "err_msg_please_enter_valid_email".tr;
                                }
                                return null;
                              });
                        }),
                    SizedBox(height: 8.v),
                    
                    // Password field
                    BlocSelector<LoginBloc, LoginState, TextEditingController?>(
                        selector: (state) => state.passwordController,
                        builder: (context, passwordController) {
                          return CustomTextFormField(
                              controller: passwordController,
                              hintText: "lbl_password".tr,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              prefix: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgLocation,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize)),
                              prefixConstraints: BoxConstraints(maxHeight: 48.v),
                              validator: (value) {
                                if (value == null ||
                                    (!isValidPassword(value, isRequired: true))) {
                                  return "err_msg_please_enter_valid_password".tr;
                                }
                                return null;
                              },
                              obscureText: true);
                        }),
                    SizedBox(height: 27.v),
                    
                    // Sign in button with loading state
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          text: state.isLoading ? "lbl_signing_in".tr : "lbl_sign_in".tr,
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle: CustomTextStyles.titleSmallTeal300,
                          onPressed: state.isLoading 
                            ? null 
                            : () {
                                onTapSignIn(context);
                              },
                        );
                      },
                    ),
                    
                    // Loading indicator
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return Padding(
                            padding: EdgeInsets.only(top: 16.v),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    
                    // SizedBox(height: 24.v),
                    // _buildDivider(context),
                    // SizedBox(height: 24.v),
                    // _buildSocialButtons(context),
                    // SizedBox(height: 5.v)
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPageTitle(BuildContext context) {
    return Column(children: [
      // Add your app logo here
      // CustomImageView(
      //     imagePath: ImageConstant.yourAppLogo,
      //     height: 42.v,
      //     width: 115.h),
      SizedBox(height: 26.v),
      Text("msg_welcome_to_hidoc".tr,
          style: CustomTextStyles.titleMediumOnPrimaryContainer),
      SizedBox(height: 12.v),
      Text("msg_sign_in_to_continue".tr,
          style: CustomTextStyles.labelLargeGray50)
    ]);
  }

  /// Section Widget
  Widget _buildDivider(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 8.v, bottom: 9.v),
                  child: SizedBox(width: 137.h, child: Divider())),
              Text("lbl_or".tr, style: theme.textTheme.bodyLarge),
              Padding(
                  padding: EdgeInsets.only(top: 8.v, bottom: 9.v),
                  child: SizedBox(width: 137.h, child: Divider()))
            ]));
  }

  /// Section Widget
  Widget _buildSocialButtons(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 54.h, right: 58.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: ImageConstant.imgFacebook,
              height: 24.adaptSize,
              width: 24.adaptSize,
              onTap: () {}),
          Padding(
              padding: EdgeInsets.only(left: 83.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgContrast,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  onTap: () {})),
          Padding(
              padding: EdgeInsets.only(left: 87.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLinkedin,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  onTap: () {}))
        ]));
  }

  /// Handle sign in button press
  /// 
  /// Validates form and triggers login event
  void onTapSignIn(BuildContext context) {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // Get email and password from controllers
    final emailController = context.read<LoginBloc>().state.emailController;
    final passwordController = context.read<LoginBloc>().state.passwordController;
    
    if (emailController == null || passwordController == null) {
      return;
    }
    
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    
    // Dispatch login event
    context.read<LoginBloc>().add(
      LoginButtonPressed(
        email: email,
        password: password,
      ),
    );
  }
}
