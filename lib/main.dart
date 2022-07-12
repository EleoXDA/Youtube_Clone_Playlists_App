import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:provider/provider.dart';

import 'src/adaptive_login.dart';
import 'src/app_state.dart';
import 'src/adaptive_playlists.dart';

// From https://developers.google.com/youtube/v3/guides/auth/installed-apps#identify-access-scopes
final scopes = [
  'https://www.googleapis.com/auth/youtube.readonly',
];

final clientId = ClientId(
  '371277337694-01thn1rus1j9fo116olv3avn7dth9thk.apps.googleusercontent.com',
  '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',
);

void main() {
  runApp(ChangeNotifierProvider<AuthedUserPlaylists>(
    create: (context) => AuthedUserPlaylists(),
    child: const PlaylistsApp(),
  )); //  ChangeNotifierProvider
} //  main

class PlaylistsApp extends StatelessWidget {
  const PlaylistsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Playlists',
      theme: FlexColorScheme.light(scheme: FlexScheme.red).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.red).toTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: AdaptiveLogin(
        builder: (context, authClient) {
          context.read<AuthedUserPlaylists>().authClient = authClient;
          return const AdaptivePlaylists();
        }, // AdaptiveLogin.builder
        clientId: clientId,
        scopes: scopes,
        loginButtonChild: const Text('Login to YouTube'),
      ), // AdaptiveLogin
    ); // MaterialApp
  } // build
} // PlaylistsApp
