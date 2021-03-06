import 'package:better_tube/fragments/custom_appbar.dart';
import 'package:better_tube/fragments/loading.dart';
import 'package:better_tube/ui/categories_page.dart';
import 'package:better_tube/ui/login_page.dart';
import 'package:better_tube/ui/profile_page.dart';
import 'package:better_tube/ui/subscriptions_page.dart';
import 'package:better_tube/services/auth/auth.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  int _currentIndex = 2;
  final List<Widget> _children = [
    CategoriesPage(),
    SubscriptionsPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index){
    setState(() {
     _currentIndex = index; 
    });
  }

  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.currentUser().then((FirebaseUser user) {
      setState(() {
        authStatus = user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return Loading('Loading');
      case AuthStatus.notSignedIn:
        return LoginPage();
      case AuthStatus.signedIn:
        return Scaffold(
          appBar: CustomAppBar(),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            fixedColor: Colors.red,
            iconSize: 24.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Subscriptions'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ])
        );
    }
    return null;
  }
  
}