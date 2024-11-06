// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/dashboard/data/datasource/dashboard_data_source.dart';
import 'package:finwell/feature/dashboard/domain/entities/dashboard_model.dart';
import 'package:finwell/feature/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fpdart/src/either.dart';

class DashboardRepoImpl implements DashboardRepository {
  DashboardDataSource dataSource;
  DashboardRepoImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, DashboardModel>> getDashboardData(
      String month, String year) async {
    // TODO: implement getDashboardData
    try {
      DashboardModel result = await dataSource.getDashboardData(month, year);

      return right(result);
    } catch (e) {
      return left(e as Failure);
    }
  }
}
