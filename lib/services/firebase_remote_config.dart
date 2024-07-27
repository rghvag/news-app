
import 'package:firebase_remote_config/firebase_remote_config.dart';
class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setDefaults({'country_code': 'us'});
    await fetchAndActivate();
  }

  Future<bool> fetchAndActivate() async {
    return await _remoteConfig.fetchAndActivate();
  }

  String getCountryCode() {
    return _remoteConfig.getString('country_code');
  }
}
