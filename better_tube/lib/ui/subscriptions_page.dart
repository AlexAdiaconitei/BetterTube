import 'package:better_tube/fragments/channel_fragment.dart';
import 'package:better_tube/fragments/loading.dart';
import 'package:better_tube/models/channels_model.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:better_tube/services/youtube-api/api_service.dart';
import 'package:flutter/material.dart';

class SubscriptionsPage extends StatefulWidget {
  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  List<Channels> _channels;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _initChannel();
    });
  }

  _initChannel() async {
    // List<Channels> channels = await APIService.instance
    //     .fetchSubscriptions(AuthProvider.of(context).auth.accessToken);
    // setState(() {
    //   _channels = channels;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _channels != null ?
          ListView.builder(
            itemCount: _channels.length,
            itemBuilder: (BuildContext context, int index) {
              return ChannelFragment(_channels[index]);
            },
          )
          : Loading('Fetching Your Subscriptions'),
    );
  }
}