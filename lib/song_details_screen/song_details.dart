import 'dart:ui';

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Track Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(12, 0, 10, 0),
          left: true,
          right: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(track.trackName),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Artist',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(track.artistName),
                SizedBox(
                  height: 20,
                ),
                Text('Album Name',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(track.albumName),
                SizedBox(
                  height: 20,
                ),
                Text('Explicit',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(track.explicit ? 'True' : 'False'),
                SizedBox(
                  height: 20,
                ),
                Text('Rating',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(track.trackRating.toString()),
                SizedBox(
                  height: 20,
                ),
                Text('Lyrics',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(lyricsData.lyrics)
              ],
            ),
          )),
    );
  }
}
