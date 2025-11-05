import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/serviceList_item_model.dart';
import '../models/doctorlist_item_model.dart';
import 'package:flutter_bloc_boilerplate/presentation/dashboard_page/models/dashboard_model.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// A bloc that manages the state of a Dashboard according to the event that is dispatched to it.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(DashboardState initialState) : super(initialState) {
    on<DashboardInitialEvent>(_onInitialize);
  }

  List<ServicesItemModel> fillServiceListItemList() {
    return [
      ServicesItemModel(name: "Doctors",ticket: ImageConstant.imgDoctor),
      ServicesItemModel(name: "Pharmacy", ticket: ImageConstant.imgPharmacy),
      ServicesItemModel(name: "Services", ticket: ImageConstant.imgSettings),
      ServicesItemModel(name: "Articles", ticket: ImageConstant.imgArticles)
    ];
  }

  List<DoctorlistItemModel> fillDoctorListItemList() {
    return [
      DoctorlistItemModel(
          drMarcusHorizo: ImageConstant.imgThumbnail,
          drMarcusHorizo1: "Example Item 1",
          chardiologist: "Category A",
          ratting: "4,7",
          distance: "800m away"),
      DoctorlistItemModel(
          drMarcusHorizo: ImageConstant.imgThumbnail,
          drMarcusHorizo1: "Example Item 2",
          chardiologist: "Category B",
          ratting: "4,9",
          distance: "1,5km away"),
      DoctorlistItemModel(
          drMarcusHorizo: ImageConstant.imgThumbnail,
          drMarcusHorizo1: "Example Item 3",
          chardiologist: "Category C",
          ratting: "4,8",
          distance: "2km away")
    ];
  }

  _onInitialize(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(searchController: TextEditingController()));
    emit(state.copyWith(
        dashboardModelObj: state.dashboardModelObj?.copyWith(
            serviceListItemList: fillServiceListItemList(),
            doctorListItemList: fillDoctorListItemList())));
  }
}
