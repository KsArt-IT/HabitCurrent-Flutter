import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  final _show = false;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (_show) {
      debugPrint('onCreate -- bloc: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (_show) {
      debugPrint('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (_show) {
      debugPrint('onChange -- bloc: ${bloc.runtimeType}, event: $change');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (_show) {
      debugPrint(
        'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition',
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (_show) {
      debugPrint('onError -- bloc: ${bloc.runtimeType}, error: $error');
    }
    super.onError(bloc, error, stackTrace);
  }
}
