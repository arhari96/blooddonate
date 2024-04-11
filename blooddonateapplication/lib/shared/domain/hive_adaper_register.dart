import 'package:hive/hive.dart';

import '../../features/google_sign/domain/entities/google_data.dart';
import '../data/hive_adapters/user_profile_adapter.dart';

class HiveAdapterRegister {
  Future<void> registerAdapters() async {
    Hive.registerAdapter(UserProfileAdapter());
  }
}
