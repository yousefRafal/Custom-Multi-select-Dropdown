import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'select_event.dart';
part 'select_state.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc() : super(SelectInitial()) {
    on<SelectEvent>((event, emit) {
      if (event is GetLoadedEvent) {
        emit(SelectLoadingState());
        emit(LoadedDataState(options, options: selected));
      }
      if (event is AddSelectEvent) {
        emit(SelectLoadingState());
        selected.add(event.data);
        emit(LoadedDataState(options: selected, options));
      }
      if (event is RemoveSelectEvent) {
        emit(SelectLoadingState());
        selected.remove(event.opent);
        emit(LoadedDataState(options, options: selected));
      }
    });
  }

  List<String> selected = [];
  List<String> options = [
    'Yemen',
    'Yousef',
    'KSA',
    'Oman',
    'YAH',
    'Option 6',
  ];
}
