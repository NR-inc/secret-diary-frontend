import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  @protected
  final loadingProgressResult = PublishSubject<bool>();
  @protected
  final errorResult = PublishSubject<void>();
  
  Stream<bool> get loadingProgressStream => loadingProgressResult.stream;
  Stream<bool> get errorStream => loadingProgressResult.stream;
  
  @protected
  void handleError(error){
    errorResult.addError(error);
    loadingProgressResult.add(false);
  }

  void unsubscribe() {
    loadingProgressResult.add(false);
  }

  @mustCallSuper
  void dispose() {
    loadingProgressResult.close();
    errorResult.close();
  }
}
