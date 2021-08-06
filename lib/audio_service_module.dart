import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceModule extends BackgroundAudioTask {
  AudioServiceModule._privateConstructor();

  static final AudioServiceModule instance =
      AudioServiceModule._privateConstructor();

  AudioPlayer _player = AudioPlayer();

  Future<void> play() async {
    await _player.setAsset("assets/ringtones/iPhone.mp3");
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> start() async {
    await AudioService.stop();
    if (!AudioService.connected) await AudioService.connect();
    await AudioService.start(
        backgroundTaskEntrypoint: backgroundTaskEntrypoint);
  }

  onPlay() async {
    print("onPlay");
    await play();
  }

  onStop() async {
    print("onStop");
    await stop();
  }
}

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioServiceModule.instance);
}
