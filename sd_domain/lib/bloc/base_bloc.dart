import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  @protected
  var isLoading = false;
  @protected
  final _loadingProgressResult = BehaviorSubject<bool>.seeded(false);
  @protected
  final _errorResult = PublishSubject<bool>();
  @protected
  final Logger logger;

  BaseBloc({
   @required Logger logger,
  }) : this.logger = logger;

  Stream<bool> get loadingProgressStream => _loadingProgressResult.stream;

  Stream<bool> get errorStream => _errorResult.stream;

  @protected
  void showLoading(bool show) {
    isLoading = show;
    _loadingProgressResult.add(show);
  }

  @protected
  void handleError(error) {
    logger.e(error.toString());
    _errorResult.addError(error);
    showLoading(false);
  }

  void unsubscribe() {
    _loadingProgressResult.add(false);
  }

  @mustCallSuper
  void dispose() {
    _loadingProgressResult.close();
    _errorResult.close();
  }
}
