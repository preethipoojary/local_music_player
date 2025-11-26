import 'dart:typed_data';
import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  final Uint8List? data; // artwork bytes

  const AlbumArt({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "albumArt", // smooth animation between screens
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 25,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: data == null
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.grey[850],
                  child: const Icon(
                    Icons.album,
                    size: 130,
                    color: Colors.white38,
                  ),
                )
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Image.memory(
                    data!,
                    key: ValueKey(data), // fade-in when artwork changes
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
