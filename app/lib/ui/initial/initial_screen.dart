import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/ui/initial/bloc/initial_bloc.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InitialBloc(dataRepository: context.read<DataRepository>())..add(InitialLoadNameEvent()),
      child: const _InitialScreenBody(),
    );
  }
}

class _InitialScreenBody extends StatelessWidget {
  const _InitialScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitialBloc, InitialState>(
      listener: (context, state) {
        switch (state) {
          case InitialLoadingState():
            debugPrint('InitialLoadingState');
            break;
          case InitialOnboardState():
            debugPrint('InitialOnboardState');
            context.router.replace(const OnboardRoute());
          case InitialHelloState():
            debugPrint('InitialHelloState');
            context.router.replace(const HelloRoute());
          case InitialLoadedState(:final user):
            debugPrint('InitialLoadedState');
            context.read<AppBloc>().add(AppUserLoadedEvent(user: user));
            debugPrint('InitialLoadedState pop');
            context.router.pop();
          case InitialErrorState():
            debugPrint('InitialErrorState');
            context.router.pop();
        }
      },
      child: const AutoRouter(),
    );
  }
}
