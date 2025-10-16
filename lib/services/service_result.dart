sealed class ServiceResult<T> {}

class SuccessStatus<T> extends ServiceResult {
  T? data;
  SuccessStatus({this.data});
}

class FailureStatus extends ServiceResult {
  String errorMessage;
  FailureStatus({required this.errorMessage});
}
