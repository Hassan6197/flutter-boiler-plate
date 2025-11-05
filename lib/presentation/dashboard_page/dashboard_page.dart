import 'package:flutter_bloc_boilerplate/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_bloc_boilerplate/widgets/app_bar/appbar_title.dart';
import 'package:flutter_bloc_boilerplate/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_search_view.dart';
import 'widgets/ServiceList_item_widget.dart';
import 'models/serviceList_item_model.dart';
import 'models/dashboard_model.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_elevated_button.dart';
import 'widgets/doctorlist_item_widget.dart';
import 'models/doctorlist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';
import 'bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<DashboardBloc>(
        create: (context) =>
            DashboardBloc(DashboardState(dashboardModelObj: DashboardModel()))
              ..add(DashboardInitialEvent()),
        child: DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 13.v),
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 5.v),
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: BlocSelector<DashboardBloc, DashboardState,
                                      TextEditingController?>(
                                  selector: (state) => state.searchController,
                                  builder: (context, searchController) {
                                    return CustomSearchView(
                                        controller: searchController,
                                        hintText: "msg_search_doctor_drugs".tr);
                                  })),
                          SizedBox(height: 20.v),
                          _buildServiceList(context),
                          SizedBox(height: 20.v),
                          _buildOfferBanner(context),
                          SizedBox(height: 42.v),
                          _buildTopDoctorSeeAll(context),
                          SizedBox(height: 10.v),
                          _buildDoctorList(context),
                          SizedBox(height: 31.v),
                          _buildHealthArticleSee(context),
                          SizedBox(height: 12.v),
                          _buildArticleRow(context)
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 90.v,
        title: AppbarTitle(
            text: "msg_find_your_desire".tr,
            margin: EdgeInsets.only(left: 20.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgUser,
              margin: EdgeInsets.fromLTRB(20.h, 14.v, 20.h, 31.v))
        ]);
  }

  /// Section Widget
  Widget _buildServiceList(BuildContext context) {
    return SizedBox(
        height: 71.v,
        child: BlocSelector<DashboardBloc, DashboardState, DashboardModel?>(
            selector: (state) => state.dashboardModelObj,
            builder: (context, dashboardModelObj) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 17.h);
                  },
                  itemCount: dashboardModelObj?.serviceListItemList.length ?? 0,
                  itemBuilder: (context, index) {
                    ServicesItemModel model =
                        dashboardModelObj?.serviceListItemList[index] ??
                            ServicesItemModel(name: "");
                    return ServiceListItemWidget(model, onTapServiceBtn: () {
                      // Example: Navigate to service-specific screen
                      // NavigatorService.pushNamed(AppRoutes.serviceScreen);
                    });
                  });
            })
    );
  }

  /// Section Widget
  Widget _buildOfferBanner(BuildContext context) {
    return Container(
        width: 335.h,
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 12.v),
        decoration: AppDecoration.fillTeal
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              SizedBox(
                  width: 168.h,
                  child: Text("msg_early_protection".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleMedium18
                          .copyWith(height: 1.50))),
              SizedBox(height: 7.v),
              CustomElevatedButton(
                  height: 26.v,
                  width: 106.h,
                  text: "lbl_learn_more".tr,
                  buttonStyle: CustomButtonStyles.fillCyan,
                  buttonTextStyle: CustomTextStyles.labelLargePrimarySemiBold)
            ]));
  }

  /// Section Widget
  Widget _buildTopDoctorSeeAll(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("lbl_top_doctor".tr, style: theme.textTheme.titleMedium),
              GestureDetector(
                  onTap: () {
                    // Example: Navigate to list screen
                    // NavigatorService.pushNamed(AppRoutes.listScreen);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: Text("lbl_see_all".tr,
                          style: CustomTextStyles.labelLargeCyan300)))
            ]
        )
    );
  }

  /// Section Widget
  Widget _buildDoctorList(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            height: 173.v,
            child: BlocSelector<DashboardBloc, DashboardState, DashboardModel?>(
                selector: (state) => state.dashboardModelObj,
                builder: (context, dashboardModelObj) {
                  return ListView.separated(
                      padding: EdgeInsets.only(left: 20.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 14.h);
                      },
                      itemCount:
                          dashboardModelObj?.doctorListItemList.length ?? 0,
                      itemBuilder: (context, index) {

                        DoctorlistItemModel model =
                            dashboardModelObj?.doctorListItemList[index] ??
                                DoctorlistItemModel();
                        return DoctorlistItemWidget(model, onTapDoctor: () {
                          // Example: Navigate to detail screen
                          // NavigatorService.pushNamed(AppRoutes.detailScreen);
                        });
                      });
                })));
  }

  /// Section Widget
  Widget _buildHealthArticleSee(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 23.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("lbl_health_article".tr, style: theme.textTheme.titleMedium),
          GestureDetector(
              onTap: () {
                // Example: Navigate to articles/list screen
                // NavigatorService.pushNamed(AppRoutes.articlesScreen);
              },
              child: Padding(
                  padding: EdgeInsets.only(bottom: 3.v),
                  child: Text("lbl_see_all".tr,
                      style: CustomTextStyles.labelLargeCyan300)))
        ]));
  }

  /// Section Widget
  Widget _buildArticleRow(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.all(5.h),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgThumbnail,
                  height: 55.adaptSize,
                  width: 55.adaptSize,
                  radius: BorderRadius.circular(6.h)),
              Padding(
                  padding: EdgeInsets.only(left: 12.h, bottom: 5.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 179.h,
                            child: Text("msg_the_25_healthiest".tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.labelMediumOnPrimary
                                    .copyWith(height: 1.50))),
                        SizedBox(height: 8.v),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("lbl_jun_10_2021".tr,
                                  style: theme.textTheme.labelSmall),
                              Container(
                                  height: 2.adaptSize,
                                  width: 2.adaptSize,
                                  margin: EdgeInsets.only(
                                      left: 5.h, top: 3.v, bottom: 4.v),
                                  decoration: BoxDecoration(
                                      color: appTheme.gray500,
                                      borderRadius:
                                          BorderRadius.circular(1.h))),
                              Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text("lbl_5min_read".tr,
                                      style: theme.textTheme.labelSmall))
                            ])
                      ]))
            ]));
  }

}
