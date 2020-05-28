export 'network_mocks.dart';

import 'package:mockito/mockito.dart';
import 'package:sddomain/export/domain.dart';

class MockLoginResponseMapper extends Mock implements LoginResponseMapper {}

class MockRegistrationResponseMapper extends Mock
    implements RegistrationResponseMapper {}
