import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final loadingProgress = PublishSubject<bool>();

  void unsubscribe(){}

  @mustCallSuper
  void dispose(){
    loadingProgress.close();
  }
}
