import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyrics_app/song_details_screen/song_details.dart';
import 'package:lyrics_app/songs_list_screen/home_screen_events.dart';

import 'home_screen_bloc.dart';
import 'home_screen_states.dart';

class SongsList extends StatelessWidget {
  const SongsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongsListBloc(),
      child: SongsListScreen(),
    );
  }
}

class SongsListScreen extends StatefulWidget {
  const SongsListScreen({Key? key}) : super(key: key);

  @override
  _SongsListScreenState createState() => _SongsListScreenState();
}

class _SongsListScreenState extends State<SongsListScreen> {
  bool firstLoad = true;

  late bool hasInternet = true;
  late Connectivity connectivity;

  @override
  initState() {
    super.initState();
    connectivity = Connectivity();
    // var status = await connectivity.checkConnectivity();
    connectivity.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.mobile &&
          event != ConnectivityResult.wifi) {
        BlocProvider.of<SongsListBloc>(context).add(NoInternetEvent());
      } else if (event == ConnectivityResult.mobile) {
        print('wifi off');
        BlocProvider.of<SongsListBloc>(context).add(GetSongsListEvent());
      } else if (event == ConnectivityResult.wifi) {
        print('wifion');
        BlocProvider.of<SongsListBloc>(context).add(GetSongsListEvent());
      }
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
      ),
      body: BlocConsumer<SongsListBloc, SongsListState>(
        builder: (context, state) {
          if (firstLoad) {
            BlocProvider.of<SongsListBloc>(context).add(GetSongsListEvent());
            firstLoad = false;
          }
          if (state is NoInternetState) {
            return Center(child: Text('No internet connection'));
          }
          if (state is OnLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is OnLoadedSongsList) {
            return songsListUI(state);
          }
          return Container();
        },
        listener: (context, state) {
          if (state is OnError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
          if (state is OnLoadedSongDetails) {
            navigateToDetails(context, state);
          }
        },
      ),
    );
  }

  void navigateToDetails(BuildContext context, OnLoadedSongDetails state) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SongDetailsScreen(
              track: state.trackDetails, lyricsData: state.lyrics)),
    );
    firstLoad = true;
  }
}

ListView songsListUI(OnLoadedSongsList state) {
  return ListView.separated(
    itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          BlocProvider.of<SongsListBloc>(context)
              .add(GetSongDetailsEvent(state.songs[index].trackId));
        },
        leading: Icon(Icons.music_note),
        title: Text(state.songs[index].trackName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.songs[index].artistName),
            SizedBox(
              height: 6,
            ),
            Text(state.songs[index].albumName)
          ],
        ),
      );
    },
    itemCount: state.songs.length,
    separatorBuilder: (BuildContext context, int index) {
      return Divider(
        color: Colors.orange,
      );
    },
  );
}
