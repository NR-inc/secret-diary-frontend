import 'package:sddata/network/grapqhql_query.dart';

class UserApi {
  static GraphQlQuery profile() => GraphQlQuery(query: '''
 query {
    profile {
      first_name,
      last_name,
      email
    }
 }
''');
}
