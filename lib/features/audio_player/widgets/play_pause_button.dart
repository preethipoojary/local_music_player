import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;

  const PlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 85,
        height: 85,

        // ⭐ Smooth scaling effect when switching play/pause
        transform: Matrix4.identity()..scale(isPlaying ? 1.05 : 1.0),

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          // ⭐ Gradient Spotify effect
          gradient: const LinearGradient(
            colors: [Color(0xFF1DB954), Color(0xFF1ED760)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          // ⭐ Glow shadow effect
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1DB954).withOpacity(0.4),
              blurRadius: isPlaying ? 25 : 15,
              spreadRadius: isPlaying ? 5 : 2,
            ),
          ],
        ),

        // ⭐ Animated icon switch
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            key: ValueKey(isPlaying),
            size: 46,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
