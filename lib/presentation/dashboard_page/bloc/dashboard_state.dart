// ignore_for_file: must_be_immutable

part of 'dashboard_bloc.dart';

/// Represents the state of Dashboard in the application.
class DashboardState extends Equatable {
  DashboardState({
    this.searchController,
    this.dashboardModelObj,
  });

  TextEditingController? searchController;

  DashboardModel? dashboardModelObj;

  @override
  List<Object?> get props => [
        searchController,
        dashboardModelObj,
      ];

  DashboardState copyWith({
    TextEditingController? searchController,
    DashboardModel? dashboardModelObj,
  }) {
    return DashboardState(
      searchController: searchController ?? this.searchController,
      dashboardModelObj: dashboardModelObj ?? this.dashboardModelObj,
    );
  }
}
