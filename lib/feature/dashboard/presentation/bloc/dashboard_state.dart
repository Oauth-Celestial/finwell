// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

enum DashboardStatus {
  initial,
  loading,
  loaded,
  failed,
}

class DashboardState extends Equatable {
  DashboardStatus? status;
  DashboardModel? data;
  DashboardState({this.status, this.data});

  @override
  List<Object?> get props => [status, data];

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardModel? data,
  }) {
    return DashboardState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  static DashboardState initial() {
    return DashboardState(status: DashboardStatus.loading, data: null);
  }
}
