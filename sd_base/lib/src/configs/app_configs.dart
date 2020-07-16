import 'package:flutter/foundation.dart';
import 'package:sd_base/src/configs/build_type.dart';
import 'package:sd_base/src/configs/network_configs.dart';

class AppConfigs {
  final BuildType _buildType;
  final NetworkConfigs _networkConfigs;

  AppConfigs({
    @required BuildType buildType,
    NetworkConfigs networkConfigs,
  })  : _networkConfigs = networkConfigs ?? NetworkConfigs(buildType),
        _buildType = buildType;

  BuildType get buildType => _buildType;

  NetworkConfigs get networkConfigs => _networkConfigs;
}
