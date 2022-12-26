part of 'events_cubit.dart';

@immutable
class EventsState {
  final List<QueryDocumentSnapshot<Object?>> documents;

  EventsState({required this.documents});
}
