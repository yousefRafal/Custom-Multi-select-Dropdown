part of 'select_bloc.dart';

class SelectEvent extends Equatable {
  const SelectEvent();

  @override
  List<Object> get props => [];
}

class GetLoadedEvent extends SelectEvent {}
class AddSelectEvent extends SelectEvent {
  String data;
  AddSelectEvent(this.data);
}

class RemoveSelectEvent extends SelectEvent {
  String opent;
  RemoveSelectEvent(this.opent);
}
