import '../../domain.dart';

abstract class AppBaseBloc<State> {
  GetInstance get getInstance;
  State get state;
  Stream<State> get stream;
  void emit(State state);
}
