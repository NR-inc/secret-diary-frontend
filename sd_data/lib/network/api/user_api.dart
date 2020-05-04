import 'package:sddata/network/grapqhql_query.dart';

GraphQlQuery profile() => GraphQlQuery(query: '''
 query {
    profile {
      first_name,
      last_name,
      email
    }
 }
''');
