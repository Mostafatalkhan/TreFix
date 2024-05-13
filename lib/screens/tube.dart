import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Tube extends StatefulWidget {
  const Tube({super.key, required this.url});
  final String url;
  @override
  State<Tube> createState() => _TubeState();
}

class _TubeState extends State<Tube> {
  late YoutubePlayer youtubePlayer;
  late YoutubePlayerController _controller;
  late String id;
  @override
  void initState() {
    id = YoutubePlayer.convertUrlToId(widget.url)!;

    super.initState();
    _controller = YoutubePlayerController(initialVideoId: id);
    youtubePlayer = YoutubePlayer(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
        aspectRatio: 16 / 9,
        child: youtubePlayer,
      )),
    );
  }
}
