import 'package:flutter/foundation.dart';
import 'package:sd_base/src/configs/build_type.dart';
import 'package:sd_base/src/configs/network_configs.dart';

class AppConfigs {
  final BuildType _buildType;
  final NetworkConfigs _networkConfigs;
  final bool _skeepAuth;

  AppConfigs({
    @required BuildType buildType,
    NetworkConfigs networkConfigs,
    bool skeepAuth,
  })  : _networkConfigs = networkConfigs ?? NetworkConfigs(buildType),
        _buildType = buildType,
        _skeepAuth = skeepAuth;

  BuildType get buildType => _buildType;

  NetworkConfigs get networkConfigs => _networkConfigs;

  bool get isSkeepAuth => _skeepAuth;
}
