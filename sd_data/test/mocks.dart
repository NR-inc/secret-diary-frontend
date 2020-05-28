export 'network/network_mocks.dart';
export 'repository/repository_mocks.dart';

import 'package:mockito/mockito.dart';
import 'package:sddomain/export/domain.dart';

class MockLoginResponseMapper extends Mock implements LoginResponseMapper {}

class MockRegistrationResponseMapper extends Mock implements RegistrationResponseMapper {}
