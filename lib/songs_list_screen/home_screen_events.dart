import '../base_event_state.dart';

class SongsListEvent extends BaseEventState {}

class GetSongsListEvent extends SongsListEvent {}

class GetSongDetailsEvent extends SongsListEvent {
  final int trackId;

  GetSongDetailsEvent(this.trackId);
}

class NavigatetoTrackDetails extends SongsListEvent {}

class NoInternetEvent extends SongsListEvent {}
