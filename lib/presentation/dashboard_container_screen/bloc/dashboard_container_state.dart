// ignore_for_file: must_be_immutable

part of 'dashboard_container_bloc.dart';

/// Represents the state of DashboardContainer in the application.
class DashboardContainerState extends Equatable {
  DashboardContainerState({this.dashboardContainerModelObj});

  DashboardContainerModel? dashboardContainerModelObj;

  @override
  List<Object?> get props => [
        dashboardContainerModelObj,
      ];

  DashboardContainerState copyWith(
      {DashboardContainerModel? dashboardContainerModelObj}) {
    return DashboardContainerState(
      dashboardContainerModelObj:
          dashboardContainerModelObj ?? this.dashboardContainerModelObj,
    );
  }
}
