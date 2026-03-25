import 'package:flutter_purple_domains/flutter_purple_domains.dart';
import 'package:get_it/get_it.dart';

import '../flutter_purple_impl.dart';

final class PurpleDependency {
  static void init(GetIt i) {
    // --

    i.registerFactory<StorageDatasource>(StorageDatasourceImpl.new);

    i.registerFactory<LauncherDatasource>(LauncherDatasource.new);
    i.registerFactory<LauncherRepository>(
      () => LauncherRepositoryImpl(i.get()),
    );

    // --

    i.registerFactory<PreferencesDatasource>(
      () => PreferencesDatasource(i.get()),
    );
    i.registerFactory<PreferencesRepository>(
      () => PreferencesRepositoryImpl(i.get()),
    );

    // --

    i.registerFactory<DeviceDatasource>(DeviceDatasource.new);
    i.registerFactory<DeviceRepository>(() => DeviceRepositoryImpl(i.get()));
  }
}
