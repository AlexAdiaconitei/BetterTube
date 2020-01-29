import 'package:better_tube/models/channels_model.dart';
import 'package:better_tube/utils/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:better_tube/services/api_service.dart';

class SubscriptionsPage extends StatefulWidget {
  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  List<Channels> _channels;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _initChannel();
    });
  }

  _initChannel() async {
    List<Channels> channels = await APIService.instance
        .fetchSubscriptions(AuthProvider.of(context).auth.accessToken);
    setState(() {
      _channels = channels;
    });
  }

  _buildProfileInfo(Channels channel) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _loadMoreChannels() async {
    _isLoading = true;
    List<Channels> channels = await APIService.instance
        .fetchSubscriptions(AuthProvider.of(context).auth.accessToken);
    if(channels != null) {
      List<Channels> allChannels = _channels..addAll(channels);
      setState(() {
        _channels = allChannels;
      });
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions'),
      ),
      body: _channels != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                // if (!_isLoading &&
                //     scrollDetails.metrics.pixels ==
                //         scrollDetails.metrics.maxScrollExtent) {
                //   _loadMoreChannels();
                // }
                _loadMoreChannels();
                return false;
              },
              child: ListView.builder(
                itemCount: _channels.length,
                itemBuilder: (BuildContext context, int index) {
                  Channels channel = _channels[index];
                  return _buildProfileInfo(channel);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}