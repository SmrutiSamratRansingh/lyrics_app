import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:lyrics_app/data_models/songs_list_model.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.add(dioLoggerInterceptor);
  }
  Future<SongsData> getSongsList() async {
    try {
      Response response = await this.dio.get(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var songJson = json.decode(response.data);

        return SongsData.fromJson(songJson);
      } else {
        return SongsData.fromError("Error please try again");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return SongsData.fromError("Error please try again");
      }
      print(error);
      return SongsData.fromError("Error please try again");
    }
  }

  Future<TrackDetailResponse> getTrackDetails(int trackId) async {
    try {
      Response response = await this.dio.get(
          "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var trackJson = json.decode(response.data);

        return TrackDetailResponse.fromJson(trackJson);
      } else {
        return TrackDetailResponse.fromError("Error please try again");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return TrackDetailResponse.fromError("Error please try again");
      }
      print(error);
      return TrackDetailResponse.fromError("Error please try again");
    }
  }

  Future<LyricsDetailResponse> getTrackLyrics(int trackId) async {
    try {
      Response response = await this.dio.get(
          "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var lyricsJson = json.decode(response.data);

        return LyricsDetailResponse.fromJson(lyricsJson);
      } else {
        return LyricsDetailResponse.fromError("Error please try again");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return LyricsDetailResponse.fromError("Error please try again");
      }
      print(error);
      return LyricsDetailResponse.fromError("Error please try again");
    }
  }
}
