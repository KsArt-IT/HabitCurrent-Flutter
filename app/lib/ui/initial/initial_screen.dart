import 'dart:developer';

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
      listener: (context, state) async {
        switch (state) {
          case InitialLoadingState():
            log('InitialLoadingState', name: 'InitialScreen');
            break;
          case InitialOnboardState():
            log('InitialOnboardState', name: 'InitialScreen');
            await context.router.replace(const OnboardRoute());
          case InitialHelloState():
            log('InitialHelloState', name: 'InitialScreen');
            await context.router.replace(const HelloRoute());
          case InitialLoadedState(:final user):
            log('InitialLoadedState', name: 'InitialScreen');
            context.read<AppBloc>().add(AppUserLoadedEvent(user: user));
            log('InitialLoadedState pop', name: 'InitialScreen');
            context.router.pop();
          case InitialErrorState():
            log('InitialErrorState', name: 'InitialScreen');
            context.router.pop();
        }
      },
      child: const AutoRouter(),
    );
  }
}
