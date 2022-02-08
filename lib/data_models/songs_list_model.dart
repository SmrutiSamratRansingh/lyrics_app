class SongsData {
  late String status;
  late String message;
  late List<SongsListResponse> songList;
  SongsData.fromJson(json) {
    if (json["message"]["header"]["status_code"] == 200) {
      this.status = 'SUCCESS';
    }
    songList = [];
    for (var song in json["message"]["body"]["track_list"]) {
      var songData = SongsListResponse.fromJson(song);
      songList.add(songData);
    }
  }
  SongsData.fromError(String error) {
    this.message = error;
    this.status = 'FAILURE';
  }
}

class SongsListResponse {
  late int trackId;
  late String trackName;
  late String albumName;
  late String artistName;

  SongsListResponse.fromJson(json) {
    this.trackId = json["track"]["track_id"];
    this.trackName = json["track"]["track_name"];
    this.albumName = json["track"]["album_name"];
    this.artistName = json["track"]["artist_name"];
  }
}

class TrackDetailResponse {
  late int trackRating;
  late bool explicit;
  late String trackName;
  late String albumName;
  late String artistName;

  late String message;

  late String status;

  TrackDetailResponse.fromJson(json) {
    this.status = 'SUCCESS';
    var track = json["message"]["body"]["track"];
    this.trackName = track["track_name"];
    this.albumName = track["album_name"];
    this.artistName = track["artist_name"];
    this.trackRating = track["track_rating"];
    if (track["explicit"] == 0) {
      this.explicit = false;
    } else {
      this.explicit = true;
    }
  }
  TrackDetailResponse.fromError(String error) {
    this.message = error;
    this.status = 'FAILURE';
  }
}

class LyricsDetailResponse {
  late String lyrics;

  late String message;

  late String status;

  LyricsDetailResponse.fromJson(json) {
    this.status = 'SUCCESS';
    var songLyrics = json["message"]["body"]["lyrics"];
    this.lyrics = songLyrics["lyrics_body"];
  }
  LyricsDetailResponse.fromError(String error) {
    this.message = error;
    this.status = 'FAILURE';
  }
}
