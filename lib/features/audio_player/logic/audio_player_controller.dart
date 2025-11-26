import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dart_tags/dart_tags.dart';

class AudioPlayerController extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  String? title;
  String? artist;
  Uint8List? artwork;

  bool loading = false;

  Future<void> loadFile(String path) async {
    loading = true;
    notifyListeners();

    try {
      await player.stop();

      // Extract metadata (NON-BLOCKING FAST)
      _extractMetadata(path);

      // Load audio file IMMEDIATELY (fast)
      await player.setFilePath(path);

      // Reset when completed
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          player.seek(Duration.zero);
          player.pause();
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint("Audio load error: $e");
      title = "Could not play this file";
      artist = "";
      artwork = null;
      await player.stop();
    }

    loading = false;
    notifyListeners();
  }

  /// FAST metadata extraction (does NOT block playback)
  Future<void> _extractMetadata(String path) async {
    try {
      final parser = TagProcessor();
      final bytes = await File(path).readAsBytes();

      final tags = await parser.getTagsFromByteArray(
        Future.value(bytes.toList()),
      );

      if (tags.isEmpty) {
        title = path.split('/').last;
        artist = "Unknown Artist";
        artwork = null;
        notifyListeners();
        return;
      }

      final meta = tags.first;

      title = meta.tags["title"]?.toString() ?? path.split('/').last;
      artist = meta.tags["artist"]?.toString() ?? "Unknown Artist";

      // Album art
      if (meta.tags["APIC"] != null) {
        final apic = meta.tags["APIC"];
        if (apic is List && apic.isNotEmpty) {
          final pic = apic.first;
          if (pic is Map && pic["imageData"] != null) {
            artwork = Uint8List.fromList(pic["imageData"]);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      title = path.split('/').last;
      artist = "Unknown Artist";
      artwork = null;
      notifyListeners();
    }
  }

  void playPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
    notifyListeners();
  }

  void seek(Duration duration) {
    player.seek(duration);
    notifyListeners();
  }
}
