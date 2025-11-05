import 'package:flutter/services.dart';
import 'package:flutter_bloc_boilerplate/presentation/dashboard_page/dashboard_page.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_bottom_bar.dart';
import 'models/dashboard_container_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';
import 'bloc/dashboard_container_bloc.dart';

// ignore_for_file: must_be_immutable
class DashboardContainerScreen extends StatelessWidget {
  DashboardContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardContainerBloc>(
        create: (context) => DashboardContainerBloc(DashboardContainerState(
            dashboardContainerModelObj: DashboardContainerModel()))
          ..add(DashboardContainerInitialEvent()),
        child: DashboardContainerScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardContainerBloc, DashboardContainerState>(
        builder: (context, state) {
      return SafeArea(
          child: AnnotatedRegion(
              value: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              child: Scaffold(
                  body: Navigator(
                      key: navigatorKey,
                      initialRoute: AppRoutes.dashboardPage,
                      onGenerateRoute: (routeSetting) => PageRouteBuilder(
                          pageBuilder: (ctx, ani, ani1) =>
                              getCurrentPage(context, routeSetting.name!),
                          transitionDuration: Duration(seconds: 0))),
                  bottomNavigationBar: _buildBottomBar(context))));
    });
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.dashboardPage;
      case BottomBarEnum.Messages:
        // Example: Add your messages page route
        return AppRoutes.dashboardPage;
      case BottomBarEnum.Appointment:
        // Example: Add your appointment page route
        return AppRoutes.dashboardPage;
      case BottomBarEnum.Profile:
        // Example: Add your profile page route
        return AppRoutes.dashboardPage;
      default:
        return AppRoutes.dashboardPage;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.dashboardPage:
        return DashboardPage.builder(context);
      // Example: Add more pages here
      // case AppRoutes.messagesPage:
      //   return MessagesPage.builder(context);
      default:
        return DashboardPage.builder(context);
    }
  }
}
