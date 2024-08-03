// import 'package:get/get.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class HomepageVideoPlayerController extends GetxController {
//   late YoutubePlayerController? youtubeController;
//   var muted = true.obs;
//
//   void initializeVideo(String url) {
//     /// Initially Mute The Video Player.
//     muted(true);
//     youtubeController = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: muted.value,
//         enableCaption: false,
//         loop: true,
//       ),
//     );
//   }
//
//   void playVideo() {
//     youtubeController?.play();
//   }
//
//   void pauseVideo() {
//     if (youtubeController?.value.isPlaying ?? false) {
//       youtubeController?.pause();
//     }
//   }
//
//   void muteVideo() {
//     muted(true);
//     youtubeController?.mute();
//   }
//
//   void unMuteVideo() {
//     muted(false);
//     youtubeController?.unMute();
//   }
//
//   @override
//   void onClose() {
//     if (youtubeController?.value.isPlaying ?? false) {
//       youtubeController?.pause();
//     }
//     youtubeController?.dispose();
//     super.onClose();
//   }
// }
