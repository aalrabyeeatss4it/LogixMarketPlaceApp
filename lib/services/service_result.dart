sealed class ServiceResult<T> {}

class SuccessStatus extends ServiceResult {}

class FailureStatus extends ServiceResult {
  String errorMessage;
  FailureStatus({required this.errorMessage});
}
