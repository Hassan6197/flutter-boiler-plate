import '../models/doctorlist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/core/app_export.dart';

// ignore: must_be_immutable
class DoctorlistItemWidget extends StatelessWidget {
  DoctorlistItemWidget(
    this.doctorlistItemModelObj, {
    Key? key,
    this.onTapDoctor,
  }) : super(
          key: key,
        );

  DoctorlistItemModel doctorlistItemModelObj;

  VoidCallback? onTapDoctor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            onTapDoctor!.call();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 6.h,
              vertical: 10.v,
            ),
            decoration: AppDecoration.outlineTeal.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 11.v),
                Expanded(child: CustomImageView(
                  imagePath: doctorlistItemModelObj?.drMarcusHorizo,
                  height: 68.adaptSize,
                  width: 68.adaptSize,
                  radius: BorderRadius.circular(
                    34.h,
                  ),
                  alignment: Alignment.center,
                )),

                SizedBox(height: 18.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    doctorlistItemModelObj.drMarcusHorizo1!,
                    style: CustomTextStyles.labelLargeOnPrimarySemiBold,
                  ),
                ),
                SizedBox(height: 3.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    doctorlistItemModelObj.chardiologist!,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                SizedBox(height: 6.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Row(
                    children: [
                      Container(
                        width: 26.h,
                        margin: EdgeInsets.only(bottom: 1.v),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgSignal,
                              height: 10.adaptSize,
                              width: 10.adaptSize,
                              margin: EdgeInsets.only(bottom: 2.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.v),
                              child: Text(
                                doctorlistItemModelObj.ratting!,
                                style: CustomTextStyles.labelSmallCyan300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 23.h,
                          top: 3.v,
                        ),
                        child: Text(
                          doctorlistItemModelObj.distance!,
                          style: CustomTextStyles.labelSmallBluegray200,
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
}
