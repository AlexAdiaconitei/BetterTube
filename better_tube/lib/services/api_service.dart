import 'dart:convert';
import 'dart:io';
import 'package:better_tube/models/channels_model.dart';
import 'package:better_tube/utils/auth/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:better_tube/models/channel_model.dart';
import 'package:better_tube/models/video_model.dart';
import 'package:better_tube/utils/keys/keys.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  String _nextPageTokenSubs = '';
  List<dynamic> _allChannelsJson;

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  /* 
    Creates a list with all suscribed channels. 
  */
  Future<List<Channels>> fetchSubscriptions(String accessToken) async {
    _allChannelsJson = new List<dynamic>();
    while(_nextPageTokenSubs != 'end') {
      await _fetchSubscriptionsAux(accessToken);
    }

    /* Parsing Json data to Channels model. */
    List<Channels> channels = [];
    _allChannelsJson.forEach(
        (json) => channels.add(
          Channels.fromMap(json['snippet']),
        ),
    );
    return channels;
  }

  /*  
    Is called while there are channels that have not been saved yet. It is done this  
    way because Youtube API has a maximum of 50 results per call. 
  */
  Future<void> _fetchSubscriptionsAux(String accessToken) async {
    Uri uri = _createUri();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
    };

    /* Get Channels */
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      /* Ending the while bucle if the final result page is reached. */
      if(data.containsKey('nextPageToken')) {
        _nextPageTokenSubs = data['nextPageToken'];
      } else {
        _nextPageTokenSubs = 'end';
      }

      /* The new results are added to the previous list. */
      List<dynamic> channelsJson = data['items'];
        _allChannelsJson.addAll(channelsJson);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Map<String, String> _createParameters() {
    Map<String, String> parameters = {
      'part': 'snippet',
      'mine' : 'true',
      'maxResults': '50',
      'pageToken': _nextPageTokenSubs,
      'order' : 'alphabetical',
      'key': API_KEY,
    };
    return parameters;
  }

  Uri _createUri() {
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/subscriptions',
      _createParameters(),
    );
    return uri;
  }

}