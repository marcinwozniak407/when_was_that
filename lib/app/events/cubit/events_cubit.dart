import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsInitial());
}
