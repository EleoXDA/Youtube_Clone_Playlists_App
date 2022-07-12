import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:split_view/split_view.dart';

import 'playlist_details.dart';
import 'playlists.dart';

class AdaptivePlaylists extends StatelessWidget {
  const AdaptivePlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final targetPlatform = Theme.of(context).platform;

    if (targetPlatform == TargetPlatform.android ||
        targetPlatform == TargetPlatform.iOS ||
        screenWidth <= 600) {
      return const NarrowDisplayPlaylists();
    } else {
      return const WideDisplayPlaylists();
    } // if
  } // build
} // AdaptivePlaylists

class NarrowDisplayPlaylists extends StatelessWidget {
  const NarrowDisplayPlaylists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Playlists')),
      body: Playlists(
        playlistSelected: (playlist) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: Text(playlist.snippet!.title!)),
                  body: PlaylistDetails(
                    playlistId: playlist.id!,
                    playlistName: playlist.snippet!.title!,
                  ), // PlaylistDetails
                ); // Scaffold
              }, // builder
            ), // MaterialPageRoute
          ); // Navigator.push
        }, // playlistSelected
      ), // Playlists
    ); // Scaffold
  } // build
} // NarrowDisplayPlaylists

class WideDisplayPlaylists extends StatefulWidget {
  const WideDisplayPlaylists({
    Key? key,
  }) : super(key: key); // WideDisplayPlaylists

  @override
  State<WideDisplayPlaylists> createState() => _WideDisplayPlaylistsState();
} // WideDisplayPlaylists

class _WideDisplayPlaylistsState extends State<WideDisplayPlaylists> {
  Playlist? selectedPlaylist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedPlaylist == null
            ? const Text('User Playlists')
            : Text('User Playlist: ${selectedPlaylist!.snippet!.title!}'),
      ), // AppBar
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        children: [
          Playlists(playlistSelected: (playlist) {
            setState(() {
              selectedPlaylist = playlist;
            }); // setState
          }), // Playlists
          if (selectedPlaylist != null)
            PlaylistDetails(
                playlistId: selectedPlaylist!.id!,
                playlistName: selectedPlaylist!.snippet!.title!)
          else
            const Center(
              child: Text('Select a playlist'),
            ), // Center
        ], // children
      ), // SplitView
    ); // Scaffold
  } // build
} // _WideDisplayPlaylistsState
