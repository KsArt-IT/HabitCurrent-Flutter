import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  static const _show = false;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (_show) {
      log('onCreate -- bloc: ${bloc.runtimeType}', name: 'AppBlocObserver');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (_show) {
      log('onEvent -- bloc: ${bloc.runtimeType}, event: $event', name: 'AppBlocObserver');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (_show) {
      log('onChange -- bloc: ${bloc.runtimeType}, event: $change', name: 'AppBlocObserver');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (_show) {
      log(
        'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition',
        name: 'AppBlocObserver',
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (_show) {
      log('onError -- bloc: ${bloc.runtimeType}, error: $error', name: 'AppBlocObserver');
    }
    super.onError(bloc, error, stackTrace);
  }
}
