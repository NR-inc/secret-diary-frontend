import 'grapqhql_query.dart';

GraphQlQuery login({String email, String password}) => GraphQlQuery(
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

GraphQlQuery registration(
        {String firstName, String lastName, String email, String password}) =>
    GraphQlQuery(
      query: '''
  mutation {
    register(
        firstName: "$firstName", 
        lastName: "$lastName,
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
