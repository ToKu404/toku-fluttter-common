import 'package:kartjis_mobile_common/network.dart';
import 'package:kartjis_mobile_common/src/core/anotations/_annotations.dart';
import 'package:kartjis_mobile_common/src/core/exceptions/_exceptions.dart';

typedef ConnectionIssueCallback = void Function(FailedRequestResolver resolver);

@singleton
class ConnectionIssueHandler extends FailedRequestHandler {
  @override
  bool canHandle(HttpEndpointBase<dynamic> endpoint, Exception error) =>
      endpoint.flags?[ConnectionIssueHandler] == true &&
      error is NoConnectionException;

  @override
  void onHandle(FailedRequestResolver resolver) {
    if (delegate == null) {
      resolver.release();
      return;
    }
    delegate!(resolver);
  }

  static bool isTaggedNoConnectionException(Exception error) =>
      error is TaggedException &&
      error.exception is NoConnectionException &&
      error.tags[ConnectionIssueHandler] == true;

  @override
  Exception transformError(Exception error) {
    assert(error is NoConnectionException,
        'Mismatched error: ${error.runtimeType}. Expected: NoConnectionException');
    return TaggedException(
      error,
      const {ConnectionIssueHandler: true},
    );
  }

  ConnectionIssueCallback? delegate;
}

// @lazySingleton
// class SetConnectionIssueCallbackUseCase
//     implements UseCase<ConnectionIssueCallback?, void> {
//   SetConnectionIssueCallbackUseCase(this._handler);

//   final ConnectionIssueHandler _handler;

//   @override
//   void call(ConnectionIssueCallback? input) {
//     _handler.delegate = input;
//   }
// }
