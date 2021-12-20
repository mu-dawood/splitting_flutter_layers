import '../services/messenger.dart';
import 'enums.dart';

class AsyncUseCaseResult<T> {
  final Future<T> Function() action;
  final IMessenger? messenger;
  const AsyncUseCaseResult({
    required this.action,
    this.messenger,
  });

  Future<T> handle() async {
    try {
      return await action();
    } catch (e) {
      messenger?.exception(e);
      rethrow;
    }
  }

  Future<T?> handleOr() async {
    try {
      return await action();
    } catch (e) {
      messenger?.exception(e);
    }
  }
}

class Failure implements Exception {
  final FailureType failureType;

  Failure(this.failureType);
}
