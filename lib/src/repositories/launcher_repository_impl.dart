import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:vector_math/vector_math.dart';

import 'package:flutter_purple_domains/flutter_purple_domains.dart';
import '../datasource/launcher_datasource.dart';

class LauncherRepositoryImpl implements LauncherRepository {
  const LauncherRepositoryImpl(this.datasource);

  final LauncherDatasource datasource;

  @override
  Future<Result> openBrowser(String url) async {
    try {
      await datasource.openBrowser(url);
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result> openMapApp(Vector2 position) async {
    try {
      await datasource.openMapApp(position);
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result> openMailApp(String email) async {
    try {
      await datasource.openMailApp(email);
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result> openSettings() async {
    try {
      await datasource.openSettings();
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }
}
