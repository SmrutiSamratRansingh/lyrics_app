import 'package:lyrics_app/data_models/songs_list_model.dart';

import '../base_event_state.dart';

class SongsListState extends BaseEventState {}

class OnLoading extends SongsListState {}

class NoInternetState extends SongsListState {}

class OnError extends SongsListState {
  final String message;

  OnError(this.message);
}

class OnLoadedSongsList extends SongsListState {
  final List<SongsListResponse> songs;

  OnLoadedSongsList(this.songs);
}

class OnLoadedSongDetails extends SongsListState {
  final TrackDetailResponse trackDetails;
  final LyricsDetailResponse lyrics;
  OnLoadedSongDetails(this.trackDetails, this.lyrics);
}
