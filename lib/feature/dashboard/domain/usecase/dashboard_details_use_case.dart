// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/usecase/use_cases.dart';
import 'package:finwell/feature/dashboard/domain/entities/dashboard_model.dart';
import 'package:finwell/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/src/either.dart';

class DashboardDetailsUseCase
    implements UseCases<DashboardModel, DetailParams> {
  DashboardRepository repository;
  DashboardDetailsUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, DashboardModel>> call(DetailParams parameters) async {
    // TODO: implement call
    return repository.getDashboardData(parameters.month, parameters.year);
  }
}

class DetailParams {
  String month;
  String year;
  DetailParams({required this.year, required this.month});
}
