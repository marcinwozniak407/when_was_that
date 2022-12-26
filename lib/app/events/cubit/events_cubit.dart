import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit()
      : super(const EventsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));
}
