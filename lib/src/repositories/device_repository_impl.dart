import 'package:error_handler_with_result/error_handler_with_result.dart';
import 'package:flutter/services.dart';

import '../../domain/repositories/device_repository.dart';
import '../datasource/device_datasource.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  const DeviceRepositoryImpl(this.deviceDatasource);

  final DeviceDatasource deviceDatasource;

  @override
  Future<Result> copyToClipboard(String text) async {
    try {
      await deviceDatasource.copyToClipboard(text);
      return const Result.success();
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }

  @override
  Future<Result<String?>> getClipboardData() async {
    try {
      final data = await Clipboard.getData('text/plain');
      return Result.success(data?.text);
    } catch (e, s) {
      return Result.failureFromCatch(e, s);
    }
  }
}
