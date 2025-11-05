import '../models/serviceList_item_model.dart';
import 'package:flutter_bloc_boilerplate/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';

// ignore: must_be_immutable
class ServiceListItemWidget extends StatelessWidget {
  ServiceListItemWidget(
    this.serviceListItemModelObj, {
    Key? key,
    this.onTapServiceBtn,
  }) : super(
          key: key,
        );

  ServicesItemModel serviceListItemModelObj;

  VoidCallback? onTapServiceBtn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 71.h,
      child: CustomIconButton(
        height: 71.adaptSize,
        width: 71.adaptSize,
        padding: EdgeInsets.all(16.h),
        decoration: IconButtonStyleHelper.fillCyan,
        onTap: () {
          onTapServiceBtn!.call();
        },
        child: CustomImageView(
          imagePath: serviceListItemModelObj?.ticket,
        ),
      ),
    );
  }
}
