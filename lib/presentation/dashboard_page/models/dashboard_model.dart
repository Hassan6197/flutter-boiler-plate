// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'serviceList_item_model.dart';
import 'doctorlist_item_model.dart';

/// This class defines the variables used in the [dashboard_page],
/// and is typically used to hold data that is passed between different parts of the application.
class DashboardModel extends Equatable {
  DashboardModel({
    this.serviceListItemList = const [],
    this.doctorListItemList = const [],
  }) {}

  List<ServicesItemModel> serviceListItemList;

  List<DoctorlistItemModel> doctorListItemList;

  DashboardModel copyWith({
    List<ServicesItemModel>? serviceListItemList,
    List<DoctorlistItemModel>? doctorListItemList,
  }) {
    return DashboardModel(
      serviceListItemList: serviceListItemList ?? this.serviceListItemList,
      doctorListItemList: doctorListItemList ?? this.doctorListItemList,
    );
  }

  @override
  List<Object?> get props => [serviceListItemList, doctorListItemList];
}
