import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:sddata/network/network_executor.dart';

class MockNetworkClient extends Mock implements Dio {}

class MockNetworkExecutor extends Mock implements NetworkExecutor {}