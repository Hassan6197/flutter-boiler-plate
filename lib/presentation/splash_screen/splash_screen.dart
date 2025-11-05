import 'package:flutter/services.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_outlined_button.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_elevated_button.dart';
import 'models/splash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';
import 'bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context) =>
            SplashBloc(SplashState(splashModelObj: SplashModel()))
              ..add(SplashInitialEvent()),
        child: SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return SafeArea(
          child: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: appTheme.cyan300,
            ),
            child: Scaffold(
              backgroundColor: appTheme.cyan300,
              body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 46.v),
                child: Column(
                  children: [
                    Spacer(),
                    // Add your app logo here
                    // CustomImageView(
                    //   imagePath: ImageConstant.yourAppLogo,
                    //   height: 350.v,
                    //   width: 338.h,
                    //   fit: BoxFit.fitHeight,
                    // ),
                    Text(
                      "Flutter Boilerplate",
                      style: theme.textTheme.displayMedium?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 87.v),
                    CustomOutlinedButton(
                      text: "lbl_login".tr,
                      margin: EdgeInsets.only(right: 6.h),
                      onPressed: () {
                        onTapLogin(context);
                      },
                    ),
                    SizedBox(height: 15.v),
                    CustomElevatedButton(
                      text: "lbl_sign_up".tr,
                      margin: EdgeInsets.only(right: 6.h),
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      buttonTextStyle: CustomTextStyles.titleSmallTeal300,
                      onPressed: () {
                        onTapSignUp(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLogin(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
  }

  /// Example: Navigate to signup screen (add your signup screen first)
  onTapSignUp(BuildContext context) {
    // NavigatorService.pushNamed(
    //   AppRoutes.signupScreen,
    // );
    // For now, navigate to login
    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
  }
}
