import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/dashboard/domain/entities/dashboard_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, DashboardModel>> getDashboardData(
      String month, String year);
}
