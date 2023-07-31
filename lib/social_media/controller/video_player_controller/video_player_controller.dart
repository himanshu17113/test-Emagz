import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class GetXVideoPlayerController extends GetxController{
  VideoPlayerController? controller;
  RxString currentId = RxString("");
  Map<String,VideoPlayerController> controllers = {};
  RxBool isPlayed = RxBool(false);
  RxDouble pauseVisibilityController = RxDouble(0);
  setVideoController(String url,String id) async{
    controller?.pause();
    if(controllers.containsKey(id)){
      controller = controllers[id]!;
      isPlayed.value = true;
      currentId.value = id;
      controller!.setLooping(true);
      controller?.play();
      update();
      return;
    }
    controller = VideoPlayerController.network(url,videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))..initialize().then((value) => update());
    isPlayed.value = true;
    controller!.setLooping(true);
    controller?.play();
    controllers[id] = controller!;
    currentId.value = id;
    update();
  }

  void togglePlay() {
    if(controller!.value.isPlaying) {
      isPlayed.value = false;
      pauseVisibilityController.value = 1.0;
      controller?.pause();
    }else{
      isPlayed.value = true;
      pauseVisibilityController.value = 0.5;
      controller?.play();
    }
  }

  @override
  void onClose() {
    controllers.forEach((key, value) {
      controllers[key]?.dispose();
    });
    controller?.dispose();
    super.onClose();
  }
}