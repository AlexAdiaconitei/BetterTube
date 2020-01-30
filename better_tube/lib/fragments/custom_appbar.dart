import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: 
        Image.asset(
          'assets/youtube_icon.png',
          fit: BoxFit.cover,
          height: 40.0,
        ),
      actions: <Widget>[
        Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(AuthProvider.of(context).auth.user.photoUrl,),
            )
          ],
        ),
        SizedBox(width: 10,),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);

}