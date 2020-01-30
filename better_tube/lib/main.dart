import 'package:better_tube/ui/root_page.dart';
import 'package:better_tube/services/auth/auth.dart';
import 'package:better_tube/services/auth/auth_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'BetterTube',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => RootPage(),
        },
      ),
    );
  }
}