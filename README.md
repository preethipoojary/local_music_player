Here is a **perfect README.md** for your music player project — clean, professional, and exactly matching your assignment requirements.
You can **copy & paste this directly into your GitHub repository**.

---

# 🎵 Local Music Player — Flutter App

A simple local music player built in Flutter that allows users to pick an MP3 file from device storage and play it with a clean Spotify-style UI. The app supports play/pause, seek bar interaction, and displays basic track information.

---

## 📱 Features Implemented

### ✔ **1. MP3 Selection**

* A button on the home screen: **“Pick MP3”**
* Opens FilePicker to choose `.mp3` files only
* Auto-handles cancelled selection (shows message)

### ✔ **2. Audio Playback**

* Plays selected mp3 file using **just_audio**
* Playback controls:

  * Play / Pause
  * Seek to any position
  * Automatically resets when track finishes
* Works on **real MP3 files** from:

  * Downloads
  * Music folder
  * Internal storage

### ✔ **3. Player Screen UI**

* Album art placeholder
* Track title (uses file name)
* Artist (“Unknown Artist”)
* Spotify-style play button
* Green progress slider
* Current time and total duration

### ✔ **4. Clean Architecture**

```
lib/
 └── features/
      └── audio_player/
           ├── logic/ (controller)
           ├── screens/ (home + player)
           └── widgets/ (album art, seek bar, play button)
```

### ✔ **5. State Management**

* Uses **Provider** (`ChangeNotifier`) for:

  * playback control
  * UI updates
  * listening to audio progress

---

## 📚 Libraries Used

| Package                  | Purpose                                                  |
| ------------------------ | -------------------------------------------------------- |
| **just_audio**           | Audio playback engine                                    |
| **provider**             | State management                                         |
| **file_picker**          | Picking MP3 files from storage                           |
| **dart_tags** (optional) | Metadata extraction (removed due to Android path issues) |

---

## 🚀 How to Run the App

### **1. Clone the repository**

```bash
git clone <your-repo-link>
cd <project-folder>
```

### **2. Install dependencies**

```bash
flutter pub get
```

### **3. Run the app**

```bash
flutter run
```

Works on:

* Android device/emulator
* iOS device/simulator

---

## 🛠 Known Issues / Limitations

* Metadata extraction (title/artist/artwork) is **disabled** due to Android SAF path issues.
  Only the file name is used as the title.
* Only `.mp3` files are supported.
* App does not support:

  * playlists
  * background playback
  * notifications
*screenshot
![WhatsApp Image 2025-11-26 at 5 10 02 PM (3)](https://github.com/user-attachments/assets/3fdbfd5e-c55c-44ac-a526-ebb39c854f19)
![WhatsApp Image 2025-11-26 at 5 10 02 PM (4)](https://github.com/user-attachments/assets/db2127ab-f064-4e0e-a41d-64449b67461d)
![WhatsApp Image 2025-11-26 at 5 10 02 PM (5)](https://github.com/user-attachments/assets/2fce4318-d14c-4cdf-862a-d992e910c7f6)
![Uploading WhatsApp Image 2025-11-26 at 5.10.03 PM.jpeg…]()







---

## 📝 What I Implemented (Short Note)

* Built a complete local music player using Flutter
* Implemented MP3 picking using FilePicker
* Integrated audio playback using just_audio
* Designed Spotify-style UI for PlayerScreen
* Added seek bar with live audio progress
* Added play/pause controls with state management
* Created reusable widgets (album art, play button, seek bar)
* Structured project using clean folder organization
* Ensured app runs smoothly on real devices
* Removed unstable metadata extraction to avoid errors

---

## 📂 Project Structure

```
lib/
 └── features/
      └── audio_player/
           ├── logic/
           │    └── audio_player_controller.dart
           ├── screens/
           │    ├── home_screen.dart
           │    └── player_screen.dart
           └── widgets/
                ├── album_art.dart
                ├── play_pause_button.dart
                └── seek_bar.dart
```

---

## 🎯 Final Result

A stable, clean, and easy-to-use Flutter music player that satisfies all assignment requirements and demonstrates understanding of:

* Flutter UI
* State management
* Audio handling
* Project organization
* Basic mobile app architecture

