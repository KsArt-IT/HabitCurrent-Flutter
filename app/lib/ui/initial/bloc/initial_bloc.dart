import 'package:bloc/bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/user.dart';

part 'initial_event.dart';
part 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  final DataRepository dataRepository;

  InitialBloc({required this.dataRepository}) : super(InitialLoadingState()) {
    on<InitialLoadNameEvent>(_onLoadNameEvent);
    on<InitialHelloEvent>(_onInitNameEvent);
    on<InitialUpdateNameEvent>(_onUpdateNameEvent);
  }

  void _onLoadNameEvent(
    InitialLoadNameEvent event,
    Emitter<InitialState> emit,
  ) async {
    try {
      // await Future.delayed(const Duration(seconds: 3));
      final user = await dataRepository.loadLastUser();
      if (user == null) {
        // If the user is not found, emit the onboard state
        emit(InitialOnboardState());
        return;
      }
      // Обновим последнее посещение
      dataRepository.saveUser(user);
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      // Emit the loaded state with the name
      emit(InitialLoadedState(user));
    } catch (e) {
      print(e);
      emit(InitialErrorState(e.toString()));
    }
  }

  void _onInitNameEvent(InitialHelloEvent event, Emitter<InitialState> emit) {
    emit(InitialHelloState());
  }

  void _onUpdateNameEvent(
    InitialUpdateNameEvent event,
    Emitter<InitialState> emit,
  ) async {
    try {
      // Получить пользователя по имени в базе данных
      final user =
          await dataRepository.loadUserByName(event.name) ??
          // Создать имя в базе данных
          await dataRepository.createUserByName(event.name);
      // Обновим последнее посещение
      dataRepository.saveUser(user);
      // и перейти на главный экран
      emit(InitialLoadedState(user));
    } catch (e) {
      print(e);
      emit(InitialErrorState(e.toString()));
    }
  }
}
