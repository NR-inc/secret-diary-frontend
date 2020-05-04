class NetworkException implements Exception {
  String message;
  String description;
  ResponseStatusType responseStatusType;

  NetworkException({this.message, int statusCode, this.description}) {
    responseStatusType = mapStatusCode(statusCode);
  }

  ResponseStatusType mapStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ResponseStatusType.BAD_REQUEST;
      case 401:
        return ResponseStatusType.AUTHORIZATION;
      case 403:
        return ResponseStatusType.FORBIDDEN;
      case 404:
        return ResponseStatusType.NOT_FOUND;
    }
    return ResponseStatusType.NONE;
  }
}

enum ResponseStatusType {
  BAD_REQUEST,
  AUTHORIZATION,
  FORBIDDEN,
  NOT_FOUND,
  NONE
}
