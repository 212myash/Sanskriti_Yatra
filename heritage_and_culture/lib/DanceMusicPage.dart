// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class DanceMusicPage extends StatefulWidget {
  final String stateName;

  DanceMusicPage({super.key, required this.stateName});

  @override
  _DanceMusicPageState createState() => _DanceMusicPageState();
}

class _DanceMusicPageState extends State<DanceMusicPage> {
  final Map<String, Map<String, String>> danceMusicData = {
    "Andhra Pradesh": {
      "video": "assets/video/Kuchipudi.mp4",
      "music": "assets/audio/Kuchipudi.mp3",
      "dance_name": "Kuchipudi Dance",
      "music_name": "Kuchipudi Music",
      "dance_description":
          "\n• Classical dance form of Andhra Pradesh\n• Known for graceful movements and strong expressions\n• Traditionally performed with music and storytelling elements",
      "music_description":
          "\n• Kuchipudi music is a blend of Carnatic classical music\n• Accompanied by traditional instruments like mridangam and flute"
    },
    "Arunachal Pradesh": {
      "video": "assets/video/Monpa.mp4",
      "music": "assets/audio/Monpa.mp3",
      "dance_name": "Monpa Dance",
      "music_name": "Monpa Music",
      "dance_description":
          "\n• Traditional dance of Monpa tribe in Arunachal Pradesh\n• Performed during festivals and celebrations\n• Includes slow movements and colorful costumes",
      "music_description":
          "\n• Monpa music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of the Monpa tribe"
    },
    "Assam": {
      "video": "assets/video/Bihu.mp4",
      "music": "assets/audio/Bihu.mp3",
      "dance_name": "Bihu Dance",
      "music_name": "Bihu Music",
      "dance_description":
          "\n• Traditional folk dance of Assam\n• Performed during Bihu festival\n• Energetic dance with lively music and drumming",
      "music_description":
          "\n• Bihu music is characterized by dhol beats and pepa tunes\n• Reflects the joy of Assamese culture"
    },
    "Bihar": {
      "video": "assets/video/Jhijhian.mp4",
      "music": "assets/audio/Jhijhian.mp3",
      "dance_name": "Jhijhian Dance",
      "music_name": "Jhijhian Music",
      "dance_description":
          "\n• Traditional folk dance of Bihar\n• Performed during festivals and celebrations\n• Includes rhythmic footwork and hand gestures",
      "music_description":
          "\n• Jhijhian music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Bihar"
    },
    "Chhattisgarh": {
      "video": "assets/video/Panthi.mp4",
      "music": "assets/audio/Panthi.mp3",
      "dance_name": "Panthi Dance",
      "music_name": "Panthi Music",
      "dance_description":
          "\n• Traditional folk dance of Chhattisgarh\n• Performed during religious ceremonies\n• Includes group formations and storytelling elements",
      "music_description":
          "\n• Panthi music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Chhattisgarh"
    },
    "Goa": {
      "video": "assets/video/Fugdi.mp4",
      "music": "assets/audio/Fugdi.mp3",
      "dance_name": "Fugdi Dance",
      "music_name": "Fugdi Music",
      "dance_description":
          "\n• Traditional folk dance of Goa\n• Performed during festivals and celebrations\n• Includes circular movements and clapping",
      "music_description":
          "\n• Fugdi music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Goa"
    },
    "Gujarat": {
      "video": "assets/video/Garba.mp4",
      "music": "assets/audio/Garba.mp3",
      "dance_name": "Garba Dance",
      "music_name": "Garba Music",
      "dance_description":
          "\n• Traditional folk dance of Gujarat\n• Performed during Navratri festival\n• Includes circular movements and dandiya raas",
      "music_description":
          "\n• Garba music is characterized by dhol beats and folk tunes\n• Reflects the festive spirit of Gujarat"
    },
    "Haryana": {
      "video": "assets/video/Phag.mp4",
      "music": "assets/audio/Phag.mp3",
      "dance_name": "Ghoomar Dance",
      "music_name": "Ghoomar Music",
      "dance_description":
          "\n• Traditional Ghoomar dance of Haryana\n• Performed during festivals and celebrations\n• Includes circular movements and clapping",
      "music_description":
          "\n• Phag music is characterized by dhol beats and folk tunes\n• Reflects the festive spirit of Haryana"
    },
    "Himachal Pradesh": {
      "video": "assets/video/Nati.mp4",
      "music": "assets/audio/Nati.mp3",
      "dance_name": "Nati Dance",
      "music_name": "Nati Music",
      "dance_description":
          "\n• Traditional folk dance of Himachal Pradesh\n• Performed during festivals and celebrations\n• Includes group formations and storytelling elements",
      "music_description":
          "\n• Nati music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Himachal Pradesh"
    },
    "Jharkhand": {
      "video": "assets/video/Chhau.mp4",
      "music": "assets/audio/Chhau.mp3",
      "dance_name": "Chhau Dance",
      "music_name": "Chhau Music",
      "dance_description":
          "\n• Traditional folk dance of Jharkhand\n• Performed during festivals and celebrations\n• Includes martial arts movements and acrobatics",
      "music_description":
          "\n• Chhau music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Jharkhand"
    },
    "Karnataka": {
      "video": "assets/video/Yakshagana.mp4",
      "music": "assets/audio/Yakshagana.mp3",
      "dance_name": "Yakshagana Dance",
      "music_name": "Yakshagana Music",
      "dance_description":
          "\n• Traditional dance drama of Karnataka\n• Performed with elaborate costumes and makeup\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Yakshagana music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like mridangam and chande"
    },
    "Kerala": {
      "video": "assets/video/Kathakali.mp4",
      "music": "assets/audio/Kathakali.mp3",
      "dance_name": "Kathakali Dance",
      "music_name": "Kathakali Music",
      "dance_description":
          "\n• Classical dance drama of Kerala\n• Known for elaborate costumes and makeup\n• Includes facial expressions and hand gestures",
      "music_description":
          "\n• Kathakali music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like chenda and ilathalam"
    },
    "Madhya Pradesh": {
      "video": "assets/video/Tertali.mp4",
      "music": "assets/audio/Tertali.mp3",
      "dance_name": "Tertali Dance",
      "music_name": "Tertali Music",
      "dance_description":
          "\n• Traditional folk dance of Madhya Pradesh\n• Performed during festivals and celebrations\n• Includes balancing acts and rhythmic movements",
      "music_description":
          "\n• Tertali music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Madhya Pradesh"
    },
    "Maharashtra": {
      "video": "assets/video/Lavani.mp4",
      "music": "assets/audio/Lavani.mp3",
      "dance_name": "Lavani Dance",
      "music_name": "Lavani Music",
      "dance_description":
          "\n• Traditional folk dance of Maharashtra\n• Performed during festivals and celebrations\n• Includes fast movements and expressions",
      "music_description":
          "\n• Lavani music is characterized by dhol beats and folk tunes\n• Reflects the cultural heritage of Maharashtra"
    },
    "Manipur": {
      "video": "assets/video/Manipuri.mp4",
      "music": "assets/audio/Manipuri.mp3",
      "dance_name": "Manipuri Dance",
      "music_name": "Manipuri Music",
      "dance_description":
          "\n• Classical dance form of Manipur\n• Known for graceful movements and expressions\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Manipuri music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like pung and pena"
    },
    "Meghalaya": {
      "video": "assets/video/Wangala.mp4",
      "music": "assets/audio/Wangala.mp3",
      "dance_name": "Nongkrem Dance",
      "music_name": "Wangala Music",
      "dance_description":
          "\n• Traditional dance nongkrem of Meghalaya\n• Performed during festivals and celebrations\n• Includes slow movements and colorful costumes",
      "music_description":
          "\n• Wangala music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Meghalaya"
    },
    "Mizoram": {
      "video": "assets/video/Cheraw.mp4",
      "music": "assets/audio/Cheraw.mp3",
      "dance_name": "Cheraw Dance",
      "music_name": "Cheraw Music",
      "dance_description":
          "\n• Traditional folk dance of Mizoram\n• Performed during festivals and celebrations\n• Includes bamboo staves and rhythmic movements",
      "music_description":
          "\n• Cheraw music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Mizoram"
    },
    "Nagaland": {
      "video": "assets/video/Tribal.mp4",
      "music": "assets/audio/Tribal.mp3",
      "dance_name": "Chang Lo Dance",
      "music_name": "Tribal Music",
      "dance_description":
          "\n• Traditional tribal dance of Nagaland\n• Performed during festivals and celebrations\n• Includes traditional attire and props",
      "music_description":
          "\n• Tribal music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Nagaland"
    },
    "Odisha": {
      "video": "assets/video/Odissi.mp4",
      "music": "assets/audio/Odissi.mp3",
      "dance_name": "Odissi Dance",
      "music_name": "Odissi Music",
      "dance_description":
          "\n• Classical dance form of Odisha\n• Known for graceful movements and expressions\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Odissi music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like mardala and sitar"
    },
    "Punjab": {
      "video": "assets/video/Bhangra.mp4",
      "music": "assets/audio/Bhangra.mp3",
      "dance_name": "Bhangra Dance",
      "music_name": "Bhangra Music",
      "dance_description":
          "\n• Traditional folk dance of Punjab\n• Performed during Baisakhi festival\n• Includes energetic movements and drumming",
      "music_description":
          "\n• Bhangra music is characterized by dhol beats and folk tunes\n• Reflects the festive spirit of Punjab"
    },
    "Rajasthan": {
      "video": "assets/video/Ghoomar.mp4",
      "music": "assets/audio/Ghoomar.mp3",
      "dance_name": "Ghoomar Dance",
      "music_name": "Ghoomar Music",
      "dance_description":
          "\n• Traditional folk dance of Rajasthan\n• Performed during festivals and celebrations\n• Includes circular movements and clapping",
      "music_description":
          "\n• Ghoomar music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Rajasthan"
    },
    "Sikkim": {
      "video": "assets/video/Lepcha.mp4",
      "music": "assets/audio/Lepcha.mp3",
      "dance_name": "Lepcha Dance",
      "music_name": "Lepcha Music",
      "dance_description":
          "\n• Traditional folk dance of Sikkim\n• Performed during festivals and celebrations\n• Includes slow movements and colorful costumes",
      "music_description":
          "\n• Lepcha music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Sikkim"
    },
    "Tamil Nadu": {
      "video": "assets/video/Bharatanatyam.mp4",
      "music": "assets/audio/Bharatanatyam.mp3",
      "dance_name": "Bharatanatyam Dance",
      "music_name": "Bharatanatyam Music",
      "dance_description":
          "\n• Classical dance form of Tamil Nadu\n• Known for intricate footwork and expressions\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Bharatanatyam music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like mridangam and veena"
    },
    "Telangana": {
      "video": "assets/video/Perini.mp4",
      "music": "assets/audio/Perini.mp3",
      "dance_name": "Perini Dance",
      "music_name": "Perini Music",
      "dance_description":
          "\n• Traditional dance form of Telangana\n• Known for energetic movements and expressions\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Perini music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like mridangam and flute"
    },
    "Tripura": {
      "video": "assets/video/Hojagiri.mp4",
      "music": "assets/audio/Hojagiri.mp3",
      "dance_name": "Hojagiri Dance",
      "music_name": "Hojagiri Music",
      "dance_description":
          "\n• Traditional folk dance of Tripura\n• Performed during festivals and celebrations\n• Includes balancing acts and spinning movements",
      "music_description":
          "\n• Hojagiri music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Tripura"
    },
    "Uttar Pradesh": {
      "video": "assets/video/Kathak.mp4",
      "music": "assets/audio/Kathak.mp3",
      "dance_name": "Kathak Dance",
      "music_name": "Kathak Music",
      "dance_description":
          "\n• Classical dance form of Uttar Pradesh\n• Known for intricate footwork and expressions\n• Includes storytelling elements and musical accompaniment",
      "music_description":
          "\n• Kathak music is a blend of classical and folk tunes\n• Accompanied by traditional instruments like tabla and sitar"
    },
    "Uttarakhand": {
      "video": "assets/video/Jhora.mp4",
      "music": "assets/audio/Jhora.mp3",
      "dance_name": "Jhora Dance",
      "music_name": "Jhora Music",
      "dance_description":
          "\n• Traditional folk dance of Uttarakhand\n• Performed during festivals and celebrations\n• Includes group formations and storytelling elements",
      "music_description":
          "\n• Jhora music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of Uttarakhand"
    },
    "West Bengal": {
      "video": "assets/video/Baul.mp4",
      "music": "assets/audio/Baul.mp3",
      "dance_name": "Gaudiya Nritya",
      "music_name": "Baul Music",
      "dance_description":
          "\n• Traditional Gaudiya Nritya dance of West Bengal\n• Performed during festivals and celebrations\n• Includes graceful movements and expressions",
      "music_description":
          "\n• Baul music is characterized by the use of traditional instruments\n• Reflects the cultural heritage of West Bengal"
    },
  };

  @override
  Widget build(BuildContext context) {
    final stateData = danceMusicData[widget.stateName];

    return Scaffold(
      appBar: AppBar(
        title: Text("Traditional Dance & Music - ${widget.stateName}"),
        backgroundColor: const Color(0xFFF5A623), // Set AppBar color
        foregroundColor: Colors.white, // Set AppBar text color
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: stateData != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MusicItem(
                      musicPath: stateData["music"] ?? "",
                      name: stateData["music_name"] ?? "Unknown Music",
                      description: stateData["music_description"] ??
                          "No description available",
                    ),
                    const SizedBox(height: 30),
                    VideoItem(
                      videoPath: stateData["video"] ?? "",
                      name: stateData["dance_name"] ?? "Unknown Dance",
                      description: stateData["dance_description"] ??
                          "No description available",
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: Text(
                "No data available",
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}

// 🎵 Music Player Widget
class MusicItem extends StatefulWidget {
  final String musicPath;
  final String name;
  final String description;

  const MusicItem({
    super.key,
    required this.musicPath,
    required this.name,
    required this.description,
  });

  @override
  _MusicItemState createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _toggleMusic() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer
          .play(AssetSource(widget.musicPath.replaceFirst("assets/", "")));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Music: -",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: Icon(
            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            size: 40,
            color: const Color.fromARGB(255, 85, 85, 85),
          ),
          title: Text(
            widget.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: _toggleMusic,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// 🎥 Video Player Widget
class VideoItem extends StatefulWidget {
  final String videoPath;
  final String name;
  final String description;

  const VideoItem({
    super.key,
    required this.videoPath,
    required this.name,
    required this.description,
  });

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Video: -",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const Center(child: CircularProgressIndicator()),
              if (!_isPlaying)
                Container(
                  color: Colors.black54,
                  child: Icon(Icons.play_arrow, size: 50, color: Colors.white),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
