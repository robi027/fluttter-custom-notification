import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceModule extends BackgroundAudioTask {
  AudioPlayer _player = AudioPlayer();

  Future<void> play() async {
    await _player.setAsset("assets/ringtones/iPhone.mp3");
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> onPlay() async {
    print("onPlay");
    await play();
  }

  @override
  Future<void> onStop() async {
    print("onStop");
    await stop();
    return super.onStop();
  }
}
