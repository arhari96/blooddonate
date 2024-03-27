import 'package:hive/hive.dart';

import '../../features/google_sign/domain/entities/google_data.dart';

class HiveAdapterRegister {
  Future<void> registerAdapters() async {
    // Register adapters
    Hive.registerAdapter(GoogleDataAdapter());

    Hive.registerAdapter(DataAdapter());

    Hive.registerAdapter(UserProfileAdapter());
  }
}
