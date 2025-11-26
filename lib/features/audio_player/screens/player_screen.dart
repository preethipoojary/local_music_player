import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../logic/audio_player_controller.dart';
import '../widgets/album_art.dart';
import '../widgets/play_pause_button.dart';
import '../widgets/seek_bar.dart';

class PlayerScreen extends StatefulWidget {
  final String filePath;
  const PlayerScreen({super.key, required this.filePath});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    // ⭐ load audio ONE time only
    Future.microtask(() {
      Provider.of<AudioPlayerController>(
        context,
        listen: false,
      ).loadFile(widget.filePath);
    });
  }

  // ⭐ pick new MP3
  Future<void> pickAnotherMP3(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No file selected")));
      return;
    }

    final newPath = result.files.single.path!;
    final c = Provider.of<AudioPlayerController>(context, listen: false);

    await c.loadFile(newPath);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PlayerScreen(filePath: newPath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<AudioPlayerController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          c.title ?? "Now Playing",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => pickAnotherMP3(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(child: AlbumArt(data: c.artwork)),
            const SizedBox(height: 20),

            Text(
              c.title ?? widget.filePath.split('/').last,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),
            Text(
              c.artist ?? "Unknown Artist",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 35),
            SeekBar(player: c.player),

            const SizedBox(height: 35),
            Center(
              child: PlayPauseButton(
                isPlaying: c.player.playing,
                onTap: c.playPause,
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => pickAnotherMP3(context),
              icon: const Icon(Icons.audio_file),
              label: const Text("Pick Another MP3"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
