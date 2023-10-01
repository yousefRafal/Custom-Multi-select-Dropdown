part of 'select_bloc.dart';

class SelectState extends Equatable {
  const SelectState();

  @override
  List<Object> get props => [];
}

final class SelectInitial extends SelectState {}

final class SelectLoadingState extends SelectState {}

final class LoadedDataState extends SelectState {
  List<String> selectedOptions = [];
  List<String>? options = [];
  LoadedDataState(this.selectedOptions, {this.options});

  @override
  List<Object> get props => [selectedOptions, options!];
}
