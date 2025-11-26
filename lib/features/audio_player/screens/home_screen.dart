import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../logic/audio_player_controller.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> songs = [];

  /// ⭐ FIX: Uses Storage Access Framework so real MP3 files are visible
  Future<void> pickMP3(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio, // FIX: show ALL music files in Downloads/Music
      allowMultiple: false,
    );

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No file selected")));
      return;
    }

    final path = result.files.single.path!;
    setState(() {
      songs.add(path);
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlayerScreen(filePath: path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<AudioPlayerController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Local Music Player",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 80),

          // ⭐ CENTER BUTTON
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => pickMP3(context),
              child: const Text(
                "Pick MP3",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ⭐ SONGS LIST BELOW BUTTON
          if (songs.isNotEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Songs",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          Expanded(
            child: songs.isEmpty
                ? const Center(
                    child: Text(
                      "No songs added yet",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.music_note,
                            color: Colors.white70,
                          ),
                          title: Text(
                            songs[i].split('/').last,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFF1DB954),
                          ),
                          onTap: () async {
                            await c.loadFile(songs[i]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    PlayerScreen(filePath: songs[i]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
