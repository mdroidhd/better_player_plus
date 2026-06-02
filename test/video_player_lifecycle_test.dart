import 'package:better_player_enhanced/better_player.dart';
import 'package:better_player_enhanced/src/video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_video_player_controller.dart';

class _CountingVideoPlayerController extends MockVideoPlayerController {
  int pauseCallCount = 0;
  int disposeCallCount = 0;

  @override
  Future<void> pause() async {
    pauseCallCount += 1;
    return super.pause();
  }

  @override
  // ignore: must_call_super
  Future<void> dispose() async {
    disposeCallCount += 1;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('better_player_channel');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('position polling stops after texture teardown error', () async {
    var positionCalls = 0;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'create':
              return <String, dynamic>{'textureId': 1};
            case 'play':
              return null;
            case 'position':
              positionCalls += 1;
              throw PlatformException(
                code: 'Unknown textureId',
                message: 'No video player associated with texture id 1',
              );
            default:
              return null;
          }
        });

    final controller = VideoPlayerController();
    await Future<void>.delayed(Duration.zero);

    await controller.play();
    await Future<void>.delayed(const Duration(milliseconds: 750));

    expect(positionCalls, 1);
    await controller.dispose();
  });

  test('better player dispose does not send an extra pause command', () {
    final controller = BetterPlayerController(
      const BetterPlayerConfiguration(),
    );
    final videoController = _CountingVideoPlayerController();
    controller.videoPlayerController = videoController;

    controller.dispose();

    expect(videoController.pauseCallCount, 0);
    expect(videoController.disposeCallCount, 1);
  });
}
