import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit()
      : super(
          const EventsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const EventsState(
        documents: [],
        errorMessage: '',
        isLoading: false,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('events')
        .orderBy('rating', descending: true)
        .snapshots()
        .listen((data) {
      emit(
        EventsState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          EventsState(
            documents: [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
