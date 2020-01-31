import 'package:better_tube/models/channels_model.dart';
import 'package:flutter/material.dart';

class ChannelFragment extends StatelessWidget {
  final Channels channel;

  ChannelFragment(this.channel);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(channel.profilePictureUrl),
        ),
        title: Text(channel.title),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     padding: EdgeInsets.all(10.0),
  //     height: 60.0,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 1),
  //           blurRadius: 6.0,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         CircleAvatar(
  //           backgroundColor: Colors.white,
  //           radius: 25.0,
  //           backgroundImage: NetworkImage(channel.profilePictureUrl),
  //         ),
  //         SizedBox(width: 12.0),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 channel.title,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 20.0,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}