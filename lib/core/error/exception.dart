
class OfflineException implements Exception{

}
class EmptyCacheException implements Exception{}
class ServerException implements Exception{}
class InvalidDataExceptionMessage implements Exception {
  final String? message; // Custom message field

  InvalidDataExceptionMessage({this.message});
}
class InvalidDataException implements Exception{}