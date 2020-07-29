import '../grapqhql_query.dart';

class AuthApi {
  static GraphQlQuery login({String email, String password}) => GraphQlQuery(
        query: '''
  mutation {
    login(
        email: "$email", 
        password: "$password"
    ) {
      token
    }
  }
''',
        variables: {'email': email, 'password': password},
      );

  static GraphQlQuery registration(
          {String firstName, String lastName, String email, String password}) =>
      GraphQlQuery(
        query: '''
  mutation {
    register(
        firstName: "$firstName", 
        lastName: "$lastName",
        email: "$email",
        password: "$password" 
    ) {
      token
    }
  }
''',
        variables: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password
        },
      );
}
