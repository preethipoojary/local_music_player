import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SeekBar extends StatelessWidget {
  final AudioPlayer player;

  const SeekBar({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        final total = player.duration ?? Duration.zero;
        final maxSeconds = total.inSeconds > 0 ? total.inSeconds : 1;

        return Column(
          children: [
            // ⭐ Custom Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,

                // Thumb animation
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),

                // Glow on thumb
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),

                activeTrackColor: const Color(0xFF1DB954),
                inactiveTrackColor: Colors.white24,
                thumbColor: const Color(0xFF1DB954),
                overlayColor: const Color(0xFF1DB954).withOpacity(0.2),
              ),
              child: Slider(
                value: position.inSeconds.clamp(0, maxSeconds).toDouble(),
                max: maxSeconds.toDouble(),
                onChanged: (value) {
                  player.seek(Duration(seconds: value.toInt()));
                },
              ),
            ),

            const SizedBox(height: 6),

            // ⭐ Time Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _format(position),
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  _format(total),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _format(Duration d) {
    return "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
