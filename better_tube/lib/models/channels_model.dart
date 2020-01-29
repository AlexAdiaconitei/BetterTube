import 'package:better_tube/models/video_model.dart';

class Channels {

  final String id;
  final String title;
  final String profilePictureUrl;
  List<Video> videos;

  Channels({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.videos,
  });

  factory Channels.fromMap(Map<String, dynamic> map) {
    return Channels(
      id: map['resourceId']['channelId'],
      title: map['title'],
      profilePictureUrl: map['thumbnails']['default']['url'],
    );
  }

}