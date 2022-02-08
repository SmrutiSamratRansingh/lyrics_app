import 'package:flutter/material.dart';
import 'package:lyrics_app/data_models/songs_list_model.dart';

class SongDetailsScreen extends StatelessWidget {
  final TrackDetailResponse track;
  final LyricsDetailResponse lyricsData;
  const SongDetailsScreen(
      {Key? key, required this.track, required this.lyricsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(12, 0, 12, 0),
          left: true,
          right: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name'),
                Text(track.trackName),
                SizedBox(
                  height: 20,
                ),
                Text('Artist'),
                Text(track.artistName),
                SizedBox(
                  height: 20,
                ),
                Text('Album Name'),
                Text(track.albumName),
                SizedBox(
                  height: 20,
                ),
                Text('Explicit'),
                Text(track.explicit ? 'True' : 'False'),
                SizedBox(
                  height: 20,
                ),
                Text('Rating'),
                Text(track.trackRating.toString()),
                SizedBox(
                  height: 20,
                ),
                Text('Lyrics'),
                Text(lyricsData.lyrics)
              ],
            ),
          )),
    );
  }
}
