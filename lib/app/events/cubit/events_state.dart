part of 'events_cubit.dart';

@immutable
class EventsState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const EventsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
