import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyrics_app/repository/api_client.dart';
import 'package:lyrics_app/songs_list_screen/home_screen_events.dart';
import 'package:lyrics_app/songs_list_screen/home_screen_states.dart';

class SongsListBloc extends Bloc<SongsListEvent, SongsListState> {
  late final ApiClient apiClient = ApiClient();

  SongsListBloc() : super(OnLoading());

  @override
  Stream<SongsListState> mapEventToState(SongsListEvent event) async* {
    yield OnLoading();
    if (event is GetSongsListEvent) {
      var songs = await apiClient.getSongsList();
      if (songs.status == 'SUCCESS') {
        yield OnLoadedSongsList(songs.songList);
      } else {
        yield OnError("Error please try again");
      }
    }
    if (event is GetSongDetailsEvent) {
      var trackDetail = await apiClient.getTrackDetails(event.trackId);
      var lyrics = await apiClient.getTrackLyrics(event.trackId);
      if (trackDetail.status == 'SUCCESS' && lyrics.status == 'SUCCESS') {
        yield OnLoadedSongDetails(trackDetail, lyrics);
      } else {
        yield OnError("Error please try again");
      }
    }
    if (event is NoInternetEvent) {
      yield NoInternetState();
    }
  }
}
