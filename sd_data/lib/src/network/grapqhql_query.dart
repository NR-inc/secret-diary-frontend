import 'package:flutter/foundation.dart';

class GraphQlQuery {
  final String query;
  final Map<String, dynamic> variables;

  GraphQlQuery({@required this.query, this.variables});

  Map<String, dynamic> toJson() => {
        'query': query,
        'variables': variables,
      };
}
