import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  @protected
  var isLoading = false;
  @protected
  final _loadingProgressResult = BehaviorSubject<bool>.seeded(false);

  @protected
  final errorResult = PublishSubject<void>();

  Stream<bool> get loadingProgressStream => _loadingProgressResult.stream;

  Stream<bool> get errorStream => _loadingProgressResult.stream;

  @protected
  void showLoading(bool show) {
    isLoading = show;
    _loadingProgressResult.add(show);
  }

  @protected
  void handleError(error) {
    errorResult.addError(error);
    _loadingProgressResult.add(false);
    showLoading(false);
  }

  void unsubscribe() {
    _loadingProgressResult.add(false);
  }

  @mustCallSuper
  void dispose() {
    _loadingProgressResult.close();
    errorResult.close();
  }
}
