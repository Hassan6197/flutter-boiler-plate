// ignore_for_file: must_be_immutable

part of 'dashboard_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///DashboardContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class DashboardContainerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the DashboardContainer widget is first created.
class DashboardContainerInitialEvent extends DashboardContainerEvent {
  @override
  List<Object?> get props => [];
}
