import '../base_event_state.dart';

class SongsListEvent extends BaseEventState {}

class GetSongsListEvent extends SongsListEvent {}

class GetSongDetailsEvent extends SongsListEvent {
  final int trackId;

  GetSongDetailsEvent(this.trackId);
}

class NavigatetoTrackDetails extends SongsListEvent {}

// class EatingHabitSelected extends CounterEvent {
//   late final EatingHabit eatingHabit;
//   EatingHabitSelected(this.eatingHabit);
// }